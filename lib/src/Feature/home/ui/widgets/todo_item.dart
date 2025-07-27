import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';

import '../../domain/entities/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });
  final TodoEntity todo;
  final VoidCallback onToggle;

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete,
      key: Key(todo.id.toString()),
      child: SizedBox(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              // mainAxisSize: ,
              // crossAxisAlignment: start,
              children: [
                GestureDetector(
                  onTap: onToggle,
                  child: todo.isDone
                      ? Icon(IconsaxBold.tick_square, color: Color(0xffF06B42))
                      : Icon(IconsaxOutline.stop),
                ),
                SizedBox(width: 10),
                Text(
                  todo.title,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Divider(),
          ],
        ),
      ),
    );
  }
}
