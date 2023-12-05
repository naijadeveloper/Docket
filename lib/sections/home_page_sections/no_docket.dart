
// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class NoDocket extends StatelessWidget {
  const NoDocket({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You have no docket.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            )
          ),

          Text("Click the button below to create a todo for today's docket",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            )
          ),
        ]
      ),
    );
  }
}