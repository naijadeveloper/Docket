// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.enabled, 
    required this.todoName, 
    required this.todoCompleted, 
    required this.onChanged,
    required this.deleteTodo,
  });

  final bool enabled;
  final String todoName;
  final bool todoCompleted;
  final void Function() onChanged;
  final void Function() deleteTodo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top:10),
      child: Slidable(
        enabled: enabled,
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: StretchMotion(),
          children: [
            SizedBox(width: 10),
      
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
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }
}