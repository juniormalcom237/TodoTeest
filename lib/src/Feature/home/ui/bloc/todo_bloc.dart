import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test_app/src/Feature/home/domain/usecase/create_todo_usecase.dart';
import 'package:todo_test_app/src/Feature/home/domain/usecase/delete_todo_usecase.dart';
import 'package:todo_test_app/src/Feature/home/domain/usecase/get_all_todo_usecase.dart';
import 'package:todo_test_app/src/Feature/home/domain/usecase/update_todo_usecase.dart';

import 'package:todo_test_app/src/Feature/home/ui/bloc/todo_event.dart';
import 'package:todo_test_app/src/Feature/home/ui/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodoUseCase getAllTodoUseCase;
  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoBloc({
    required this.getAllTodoUseCase,
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<CreateTodoEvent>(_onCreateTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    final result = await getAllTodoUseCase();
    result.fold((failure) => emit(TodoError(failure.message)), (todos) {
      return emit(TodoLoaded(todos));
    });
  }

  Future<void> _onCreateTodo(
    CreateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await createTodoUseCase(event.todo);
    await result.fold((failure) async => emit(TodoError(failure.message)), (
      todo,
    ) async {
      final todosResult = await getAllTodoUseCase();
      todosResult.fold(
        (failure) => emit(TodoError(failure.message)),
        (todos) => emit(TodoSuccessful('Todo created successfully', todos)),
      );
    });
  }

  Future<void> _onUpdateTodo(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await updateTodoUseCase(event.todo);
    await result.fold((failure) async => emit(TodoError(failure.message)), (
      todo,
    ) async {
      final todosResult = await getAllTodoUseCase();
      todosResult.fold(
        (failure) => emit(TodoError(failure.message)),
        (todos) => emit(TodoSuccessful(null, todos)),
      );
    });
  }

  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());

    final result = await deleteTodoUseCase(event.id);
    await result.fold((failure) async => emit(TodoError(failure.message)), (
      _,
    ) async {
      final todosResult = await getAllTodoUseCase();
      todosResult.fold(
        (failure) => emit(TodoError(failure.message)),
        (todos) => emit(TodoSuccessful('Todo deleted successfully', todos)),
      );
    });
  }

  Future<void> _onToggleTodo(
    ToggleTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final toggledTodo = event.todo.copyWith(isDone: !event.todo.isDone);
    add(UpdateTodoEvent(toggledTodo));
  }
}
