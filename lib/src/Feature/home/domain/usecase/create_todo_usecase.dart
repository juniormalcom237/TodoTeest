import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class CreateTodoUseCase {
  final TodoRepository repository;

  CreateTodoUseCase(this.repository);

  Future<Either<Failure, TodoEntity>> call(TodoEntity todo) async {
    if (todo.title.trim().isEmpty) {
      // return const Left(ValidationFailure('Title cannot be empty'));
    }
    return await repository.createTodo(todo);
  }
}
