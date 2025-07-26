import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class GetAllTodoUseCase {
  final TodoRepository repository;

  GetAllTodoUseCase(this.repository);

  Future<Either<Failure, List<TodoEntity>>> call() async {
    return await repository.getAllTodos();
  }
}
