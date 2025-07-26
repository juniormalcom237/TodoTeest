import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test_app/src/Feature/home/ui/bloc/cubit/show_todo_input_cubit.dart';
import 'package:todo_test_app/src/Feature/home/ui/bloc/todo_bloc.dart';
import 'package:todo_test_app/src/Feature/home/ui/home_screen.dart';
import 'package:todo_test_app/src/core/application.dart';
import 'src/Feature/Shared/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const Application());
}
