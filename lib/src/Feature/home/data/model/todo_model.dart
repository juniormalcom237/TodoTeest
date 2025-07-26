import 'package:drift/drift.dart';

import '../../domain/entities/todo.dart';
import '../local/database.dart';

// class TodoModel extends DataClass implements Insertable<TodoModel> {
//   final int id;
//   final String title;
//
//   final bool isDone;
//
//   const TodoModel({
//     required this.id,
//     required this.title,
//     required this.isDone,
//   });
//
//   factory TodoModel.fromEntity(TodoEntity entity) {
//     return TodoModel(
//       id: entity.id ?? 0,
//       title: entity.title,
//       isDone: entity.isDone,
//     );
//   }
//
//   TodoEntity toEntity() {
//     return TodoEntity(id: id, title: title, isDone: isDone);
//   }
//
//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     map['title'] = Variable<String>(title);
//     map['isDone'] = Variable<bool>(isDone);
//
//     return map;
//   }
//
//   TodoModel copyWith({int? id, String? title, bool? isDone}) {
//     return TodoModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       isDone: isDone ?? this.isDone,
//     );
//   }
//
//   @override
//   Map<String, dynamic> toJson({ValueSerializer? serializer}) {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }
// }

// Simple extension to convert between Drift generated class and Domain Entity
extension TodoModelExtension on Todo {
  // Convert Drift Todo to Domain TodoEntity
  TodoEntity toEntity() {
    return TodoEntity(id: id, title: title, isDone: isDone);
  }
}

// Helper extension for TodoEntity to create TodosCompanion for insertions
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
