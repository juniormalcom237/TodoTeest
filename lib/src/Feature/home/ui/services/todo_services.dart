import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test_app/src/Feature/home/domain/entities/todo.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';

class TodoService {
  static final TodoService _instance = TodoService._internal();
  TodoService._internal();
  static TodoService get instance => _instance;

  void addTask(BuildContext context, String title) {
    final todo = TodoEntity(title: title, isDone: false, id: null);

    if (title.isNotEmpty) {
      context.read<TodoBloc>().add(CreateTodoEvent(todo));
      context.read<TodoBloc>().add(LoadTodos());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Title can't be empty"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void deleteTask(BuildContext context, int index) {
    context.read<TodoBloc>().add(DeleteTodoEvent(index));
  }

  void toggleTask(BuildContext context, TodoEntity todo) {
    context.read<TodoBloc>().add(ToggleTodoEvent(todo));
  }
}
