import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo_test_app/src/Feature/home/data/local/todo_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> getAllTodos() => select(todos).get();

  Future<Todo?> getTodoById(int id) =>
      (select(todos)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<Todo> createTodo(TodosCompanion todo) =>
      into(todos).insertReturning(todo);

  Future<Todo> updateTodo(TodosCompanion todo) =>
      (update(todos)..where((t) => t.id.equals(todo.id.value)))
          .writeReturning(todo)
          .then((list) => list.first);

  Future<int> deleteTodo(int id) =>
      (delete(todos)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
