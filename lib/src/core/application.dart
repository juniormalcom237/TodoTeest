import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Feature/Shared/locator.dart' as di;
import '../Feature/home/ui/bloc/cubit/show_todo_input_cubit.dart';
import '../Feature/home/ui/bloc/todo_bloc.dart';
import '../Feature/home/ui/home_screen.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.locator<TodoBloc>()),
          BlocProvider(create: (_) => ShowTodoInputCubit()),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
