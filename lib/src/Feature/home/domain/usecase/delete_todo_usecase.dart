import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repository/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteTodo(id);
  }
}
