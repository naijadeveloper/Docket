import "package:flutter/material.dart";
import 'package:docket/state/todo_model.dart';



const dayConstants = [
  "Monday", "Tuesday", "Wednesday", 
  "Thursday", "Friday", "Saturday", "Sunday"
];


@immutable
class Docket {
  const Docket({
    required this.todos,
  });

  final List<Todo> todos;

  Docket copyWith(List<Todo> todos) {
    return Docket(
      todos: todos,
    );
  }

  Map<String, int> metaData() {
    if(todos.isNotEmpty) {
      return { 
        "day": DateTime.parse(todos[0].dateTime).day,
        "month": DateTime.parse(todos[0].dateTime).month,
        "year": DateTime.parse(todos[0].dateTime).year,
      };
    }else {
      return {};
    }
  }

  String formattedMetaData() {
    if(todos.isNotEmpty) {
      var parsedDate = DateTime.parse(todos[0].dateTime);
      return "${parsedDate.month}/${dayConstants[parsedDate.weekday - 1]} ${parsedDate.day}/${parsedDate.year}";
    } else {
      return "";
    }
  }

  bool docketIsEmpty() {
    return todos.isEmpty;
  }
}