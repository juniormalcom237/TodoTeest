import 'dart:ffi';

import 'package:flutter/foundation.dart';

import '../../domain/entities/todo.dart';

@immutable
abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final TodoEntity todo;
  CreateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  DeleteTodoEvent(this.id);
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todo;
  UpdateTodoEvent(this.todo);
}

class ToggleTodoEvent extends TodoEvent {
  final TodoEntity todo;
  ToggleTodoEvent(this.todo);
}
