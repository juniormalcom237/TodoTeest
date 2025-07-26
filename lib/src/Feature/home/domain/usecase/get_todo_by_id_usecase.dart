import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class GetTodoByIdUseCase {
  final TodoRepository repository;

  GetTodoByIdUseCase(this.repository);

  Future<Either<Failure, TodoEntity>> call(int id) async {
    return await repository.getTodoById(id);
  }
}
