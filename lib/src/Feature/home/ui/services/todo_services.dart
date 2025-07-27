import 'package:flutter/cupertino.dart';

class TodoService {
  static final TodoService _instance = TodoService._internal();
  TodoService._internal();
  static TodoService get instance => _instance;

  void addTask(BuildContext context, String title) {}

  void deleteTask(BuildContext context, int index) {}

  void toggleTask(BuildContext context, int index, bool isDone) {}
}
