// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:docket/providers/dockets_provider.dart";
import "package:docket/state/todo_model.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CreateTodoDialog extends StatelessWidget {
  CreateTodoDialog({super.key});

  final TextEditingController controller = TextEditingController();

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

          Consumer(
            builder: (context, ref, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      // call save method
                      if(controller.text.length >= 3) {
                        ref.read(docketsProvider.notifier).addTodo(
                          Todo(
                            todoName: controller.text,
                            todoCompleted: false,
                            dateTime: DateTime.now().toString(),
                          ),
                        );
                        // remove widget
                        Navigator.of(context).pop();
                      }
                      // clear controller
                      controller.clear();
                    },
                    color: Colors.orange,
                    highlightElevation: 0,
                    elevation: 0,
                    highlightColor: Colors.orange[600],
                    child: Text("Save"),
                  ),
              
                  SizedBox(width: 10),
              
                  MaterialButton(
                    onPressed: () {
                      // remove dialog box
                      Navigator.of(context).pop();
                      // clear controller
                      controller.clear();
                    },
                    color: Colors.grey[700],
                    textColor: Colors.grey[100],
                    highlightElevation: 0,
                    elevation: 0,
                    highlightColor: Colors.grey[600],
                    child: Text("Cancel"),
                  )
                ]
              );
            }
          ),
        ],
      ),
    );
  }
}