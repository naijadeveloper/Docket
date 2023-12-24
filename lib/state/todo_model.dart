import 'package:flutter/material.dart';

@immutable
class Todo {
  const Todo({
    required this.todoName,
    required this.todoCompleted,
    required this.dateTime,
  });

  // All properties should be `final` on our class.
  final String todoName;
  final bool todoCompleted;
  final String dateTime;

  // Since Todo is immutable, we implement a method that allows cloning the
  // Todo with slightly different content.
  Todo copyWith({String? todoName, bool? todoCompleted, String? dateTime}) {
    return Todo(
      todoName: todoName ?? this.todoName,
      todoCompleted: todoCompleted ?? this.todoCompleted,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}