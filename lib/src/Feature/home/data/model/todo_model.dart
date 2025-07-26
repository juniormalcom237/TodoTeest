import 'package:drift/drift.dart';

import '../../domain/entities/todo.dart';
import '../local/database.dart';

extension TodoModelExtension on Todo {
  // Convert Drift Todo to Domain TodoEntity
  TodoEntity toEntity() {
    return TodoEntity(id: id, title: title, isDone: isDone);
  }
}

extension TodoEntityExtension on TodoEntity {
  // Convert Domain TodoEntity to Drift TodosCompanion for database operations
  TodosCompanion toCompanion() {
    return TodosCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      title: Value(title),

      isDone: Value(isDone),
    );
  }
}
