class TodoEntity {
  final int? id;
  final String title;
  final bool isDone;

  TodoEntity({required this.id, required this.title, required this.isDone});

  TodoEntity copyWith({int? id, String? text, bool? isDone}) {
    return TodoEntity(
      id: id ?? this.id,
      title: text ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
