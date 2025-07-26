import 'package:flutter/foundation.dart';

import '../../domain/entities/todo.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoEntity> todos;
  TodoLoaded(this.todos);
}

class ShowAddTodo extends TodoState {
  final bool isCheck;

  ShowAddTodo(this.isCheck);
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}

class TodoSuccessful extends TodoState {
  final String message;
  final List<TodoEntity> todos;
  TodoSuccessful(this.message, this.todos);
}
