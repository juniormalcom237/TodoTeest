import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test_app/src/Feature/home/ui/bloc/cubit/show_todo_input_cubit.dart';
import 'package:todo_test_app/src/Feature/home/ui/bloc/todo_bloc.dart';
import 'package:todo_test_app/src/Feature/home/ui/bloc/todo_state.dart';
import 'package:todo_test_app/src/Feature/home/ui/services/todo_services.dart';
import 'package:todo_test_app/src/Feature/home/ui/widgets/todo_item.dart';

import '../domain/entities/todo.dart';
import 'bloc/todo_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final showInputCubit = ShowTodoInputCubit();
  bool isCLicked = false;
  late TextEditingController _controller;

  List<TodoEntity> todos = [];

  TodoService todoService = TodoService.instance;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocBuilder<ShowTodoInputCubit, bool>(
      bloc: showInputCubit,
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: state == false
              ? ElevatedButton.icon(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    showInputCubit.toggleShowInput(true);

                    setState(() {
                      isCLicked = true;
                    });
                  },
                  label: Text(
                    "Add a task",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF06B42),
                  ),
                )
              : SizedBox.shrink(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Todo Test App",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),

          body: BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state is TodoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is TodoSuccessful) {
                if (state.message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              }
            },
            builder: (context, todoState) {
              if (todoState is TodoInitial) {
                context.read<TodoBloc>().add(LoadTodos());
                return const Center(child: CircularProgressIndicator());
              }
              if (todoState is TodoLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (todoState is TodoLoaded || todoState is TodoSuccessful) {
                final todos = todoState is TodoLoaded
                    ? todoState.todos
                    : (todoState as TodoSuccessful).todos;

                if (todos.isEmpty && !state) {
                  return emptyTask(context);
                }

                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              final todo = todos[index];
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  todoService.deleteTask(context, todo.id!);
                                },
                                key: Key(todo.id.toString()),
                                child: TodoItem(
                                  todo: todo,
                                  onToggle: () =>
                                      todoService.toggleTask(context, todo),
                                ),
                              );
                            },
                            itemCount: todos.length,
                          ),

                          SizedBox(
                            child: isCLicked
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(IconsaxOutline.add_square, size: 22),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: size.width * 0.8,
                                        child: TextField(
                                          controller: _controller,
                                          autofocus: true,

                                          onSubmitted: (title) {
                                            todoService.addTask(context, title);
                                            setState(() {
                                              isCLicked = false;
                                              _controller.text = "";
                                            });
                                          },
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "Task name",
                                            border: InputBorder.none,
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isCLicked = true;
                                          });
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              IconsaxOutline.add_square,
                                              size: 22,
                                            ),
                                            SizedBox(width: 9),
                                            Text(
                                              "Click to add a new task",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.secondary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Widget emptyTask(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          IconsaxOutline.emoji_sad,
          weight: 600,
          size: 60,
          color: Theme.of(context).colorScheme.secondary,
        ),
        SizedBox(height: 10),
        Text(
          "No Task Found",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text.rich(
            textAlign: TextAlign.center,
            softWrap: true,

            TextSpan(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              children: [
                TextSpan(text: "Please click on the add button "),
                WidgetSpan(child: Icon(IconsaxOutline.add_circle, size: 14)),
                TextSpan(text: " add a new task"),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
