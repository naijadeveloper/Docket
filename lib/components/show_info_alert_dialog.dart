// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";

enum Types {
  danger,
  info,
}

class InfoAlertDialog extends StatelessWidget {
  const InfoAlertDialog({
    super.key,
    required this.type,
    required this.text,
    required this.ok,
  });

  final Types type;
  final String text;
  final void Function() ok;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade800,
      insetPadding: EdgeInsets.all(30),
      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
      elevation: 0,

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,
            style: TextStyle(
              color: Colors.grey.shade200,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              onPressed: ok,
              elevation: 0,
              highlightElevation: 0,
              textColor: Colors.grey.shade200,
              color: type == Types.danger? Colors.red.shade800 : Colors.grey.shade600,
              highlightColor: type == Types.danger? Colors.red.shade700 : Colors.grey.shade700,
              child: Text(type == Types.danger? 'Yes, I\'m sure' : 'Ok',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}