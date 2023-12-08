// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";

class CreateTodoDialog extends StatelessWidget {
  const CreateTodoDialog({
    super.key,
    required this.controller, 
    required this.onSave, 
    required this.onCancel
  });

  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[100],
      elevation: 0,

      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Icon(Icons.create, size: 16),
          ),
          Text("Create a Todo",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),

      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                  width: 1.5,
                ),
              ),
              hintText: "Type in a new one",
              counterStyle: TextStyle(
                fontSize: 14,
              )
            ),
            maxLength: 35,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: onSave,
                color: Colors.orange,
                highlightElevation: 0,
                elevation: 0,
                highlightColor: Colors.orange[600],
                child: Text("Save"),
              ),

              SizedBox(width: 10),

              MaterialButton(
                onPressed: onCancel,
                color: Colors.grey[700],
                textColor: Colors.grey[100],
                highlightElevation: 0,
                elevation: 0,
                highlightColor: Colors.grey[600],
                child: Text("Cancel"),
              )
            ]
          ),
        ],
      ),
    );
  }
}