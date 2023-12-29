import 'package:flutter/material.dart';
import "package:hive_flutter/hive_flutter.dart";

part "todo_model.g.dart";

@HiveType(typeId: 0)
@immutable
class Todo {
  const Todo({
    required this.todoName,
    required this.todoCompleted,
    required this.dateTime,
  });

  // All properties should be `final` on our class.
  @HiveField(0)
  final String todoName;

  @HiveField(1)
  final bool todoCompleted;

  @HiveField(2)
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