import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<Either<Failure, TodoEntity>> call(TodoEntity todo) async {
    return await repository.updateTodo(todo);
  }
}
