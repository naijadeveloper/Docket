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

  Map<String, int> dateMetaData() {
    return { 
      "day": DateTime.parse(todos[0].dateTime).day,
      "month": DateTime.parse(todos[0].dateTime).month,
      "year": DateTime.parse(todos[0].dateTime).year,
    };
  }

  Map<String, Object> formattedMetaData() {
    var parsedDate = DateTime.parse(todos[0].dateTime);
    var completedTodos = [
      for(final aTodo in todos)
        if(aTodo.todoCompleted)
          aTodo
    ];
    
    return {
      "date": "${parsedDate.month}/${dayConstants[parsedDate.weekday - 1]} ${parsedDate.day}/${parsedDate.year}",
      "todos": todos.length,
      "completed": completedTodos.length,
    };
  }

  bool docketIsEmpty() {
    return todos.isEmpty;
  }


  static List<Docket> generateListOfDockets(savedTodos) {
    List<Todo> allTodos = [
      for(final todo in savedTodos)
        Todo(
          todoName: todo.todoName,
          todoCompleted: todo.todoCompleted,
          dateTime: todo.dateTime,
        )
    ];
    List<Docket> allDockets = [];

    while(allTodos.isNotEmpty) {
      var todosWithSameDate = [allTodos[0]];
      var [year, month, day] = [
        DateTime.parse(allTodos[0].dateTime).year, 
        DateTime.parse(allTodos[0].dateTime).month, 
        DateTime.parse(allTodos[0].dateTime).day
      ];

      allTodos.removeAt(0);

      if(allTodos.isEmpty) {
        allDockets.add(Docket(todos: todosWithSameDate));
        break;
      }

      allTodos.removeWhere((Todo todo) {
        if(DateTime.parse(todo.dateTime).year == year && 
        DateTime.parse(todo.dateTime).month == month && 
        DateTime.parse(todo.dateTime).day == day) {
          todosWithSameDate.add(todo);
          return true;
        }
        return false;
      });

      allDockets.add(Docket(todos: todosWithSameDate));
    }

    allDockets.sort((a,b) => b.dateMetaData()["day"]!.compareTo(a.dateMetaData()["day"]!));
    allDockets.sort((a,b) => b.dateMetaData()["month"]!.compareTo(a.dateMetaData()["month"]!));
    allDockets.sort((a,b) => b.dateMetaData()["year"]!.compareTo(a.dateMetaData()["year"]!));

    return allDockets;
  }
}