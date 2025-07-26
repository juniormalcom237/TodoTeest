import 'package:drift/drift.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();

  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
}
