// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key, 
    required this.todoName, 
    required this.todoCompleted, 
    required this.onChanged,
    required this.deleteTodo,
  });

  final String todoName;
  final bool todoCompleted;
  final void Function() onChanged;
  final void Function() deleteTodo;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: BehindMotion(),
        children: [
          SizedBox(width: 20),

          SlidableAction(
            onPressed: (context) => deleteTodo(),
            icon: Icons.delete,
            label: "Delete",
            backgroundColor: Colors.red.shade400,
            borderRadius: BorderRadius.circular(8),
          )
        ],
      ),

      child: Container(
        padding: EdgeInsets.all(20),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange),
        ),

        child: Row(
          children: [
            Checkbox(
              value: todoCompleted,
              onChanged: (value) => onChanged(),
              activeColor: Colors.black,
            ),

            Expanded(
              child: Text(todoName,
                style: TextStyle(
                  fontSize: 16,
                  decoration: todoCompleted == true? TextDecoration.lineThrough : TextDecoration.none,
                  decorationThickness: 2.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}