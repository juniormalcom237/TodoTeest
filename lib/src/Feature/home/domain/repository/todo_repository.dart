import '../../../../core/error/failure.dart';
import '../entities/todo.dart';
import 'package:dartz/dartz.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> getAllTodos();
  Future<Either<Failure, TodoEntity>> getTodoById(int id);
  Future<Either<Failure, TodoEntity>> createTodo(TodoEntity todo);
  Future<Either<Failure, TodoEntity>> updateTodo(TodoEntity todo);
  Future<Either<Failure, void>> deleteTodo(int id);
}
