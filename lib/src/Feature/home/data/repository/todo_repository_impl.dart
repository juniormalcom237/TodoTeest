import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:todo_test_app/src/Feature/home/data/model/todo_model.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repository/todo_repository.dart';
import '../local/database.dart';
// import'../model/todo_model.dart';
// import '../local/database.dart';

class TodoRepositoryImpl implements TodoRepository {
  final AppDatabase database;

  TodoRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTodos() async {
    try {
      final todos = await database.getAllTodos();
      return Right(todos.map((todo) => todo.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get todos: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> createTodo(TodoEntity todo) async {
    try {
      final companion = todo.toCompanion();
      final createdTodo = await database.createTodo(companion);
      return Right(createdTodo.toEntity());
    } catch (e) {
      return Left(DatabaseFailure('Failed to create todo: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo(int id) async {
    try {
      final deletedCount = await database.deleteTodo(id);
      if (deletedCount == 0) {
        return const Left(DatabaseFailure('Todo not found'));
      }
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete todo: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> updateTodo(TodoEntity todo) async {
    try {
      final companion = todo.toCompanion();
      final updatedTodo = await database.updateTodo(companion);
      return Right(updatedTodo.toEntity());
    } catch (e) {
      return Left(DatabaseFailure('Failed to update todo: ${e.toString()}'));
    }
  }
}
