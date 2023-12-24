
// ignore_for_file: unnecessary_getters_setters, prefer_const_constructors

import "package:flutter/material.dart";
import "package:docket/components/create_todo_alert_dialog.dart";
import "package:docket/components/show_info_alert_dialog.dart";

class HomeFunctions {
  HomeFunctions({
    required this.context,
    required this.setState,
    required this.updateDB,
    required List dockets,
  }) {
    docketList = dockets;
  }

  final BuildContext context;
  final void Function(void Function()) setState;
  final TextEditingController controller = TextEditingController();
  final void Function(List) updateDB;

  static const dayConstants = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  
  late List _dockets;

  List get docketList => _dockets;
  
  set docketList(List dockets) => _dockets = dockets;

  // Function to handle the clicking of the floating action button
  void handleFloatingBtnClicked() async{
    await showDialog(
      context: context, 
      builder: (context) => CreateTodoDialog(
        controller: controller,
        onSave: () {
          // todo text shouldn't be less than 3 chars
          if(controller.text.trim().length < 3) {
            return;
          }

          // the new todo to be added
          var newTodo = {"todoName": controller.text, "todoCompleted": false, "dateTime": DateTime.now().toString()};

          //save todo
          handleSavingOfTodo(newTodo);

          // update database
          updateDB(docketList);

          // pop context for dialog box 
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );

    // irrespective of whether user clicked save or cancel, clear text field
    controller.clear();
  }

  // Function to handle converting the List of todos i.e todoListing
  // to a 1-D List
  List handleConvertingDocketListTo1DListOfTodos() {
    // convert all todos to just a 1-D list
    var allTodos = [];
    for(var i = 0; i < docketList.length; i++) {
      // we don't want the meta datas included in the list
      // so we start j at 1 instead of 0
      for(var j = 1; j < docketList[i].length; j++) {
        allTodos.add(docketList[i][j]);
      }
    }

    return allTodos;
  }

    // Function to handle Sorting of todo List
  List handleSortingOfTodoList(List allTodos) {
    // sort by day
    allTodos.sort((a, b) {
      var aDay = DateTime.parse(a["dateTime"]).day;
      var bDay = DateTime.parse(b["dateTime"]).day;

      return bDay.compareTo(aDay);
    });

    // sort by month
    allTodos.sort((a, b) {
      var aMonth = DateTime.parse(a["dateTime"]).month;
      var bMonth = DateTime.parse(b["dateTime"]).month;

      return bMonth.compareTo(aMonth);
    });

    // sort by year
    allTodos.sort((a, b) {
      var aYear = DateTime.parse(a["dateTime"]).year;
      var bYear = DateTime.parse(b["dateTime"]).year;

      return bYear.compareTo(aYear);
    });

    return allTodos;
  }

  // Function to handle the seperation of todos into diff list inside the main list
  // based on whether the todos all have the same "year && month && day"
  // basicially creating a 2-D list
  List handleSeperationOfTodosBasedOnDate(List allTodos) {
    List parentList = [];
    List childList = [];

    // save date of the first item in list initially
    var dateTime1 = DateTime.parse(allTodos[0]["dateTime"]);

    while(allTodos.isNotEmpty) {
      var dateTime2 = DateTime.parse(allTodos[0]["dateTime"]);

      if(dateTime1.year == dateTime2.year && dateTime1.month == dateTime2.month && dateTime1.day == dateTime2.day) {
        //
        childList.add(allTodos[0]);
        allTodos.removeAt(0);
        continue;
        //
      }else {
        //
        parentList.add(childList);
        childList = [];
        dateTime1 = DateTime.parse(allTodos[0]["dateTime"]);
        //
      }
    }

    // childList might not be empty after break out from while loop
    if(childList.isNotEmpty) {
      parentList.add(childList);
      childList = [];
    }

    return parentList;
  }

  // Function to handle the injection into each sub lists of todo list, the first item
  // that describes the sub lists i.e how many todos it has
  // how many are completed
  // and the date it was created
  List handleInjectionOfMetaDataIntoEachSubList(List allTodos) {
    for(var i = 0; i < allTodos.length; i++) {
      var noOfTodos = allTodos[i].length;
      var noOfCompleted = 0;

      for(var j = 0; j < allTodos[i].length; j++) {
        if(allTodos[i][j]["todoCompleted"] == true) {
          noOfCompleted++;
        }
      }

      var parsedDate = DateTime.parse(allTodos[i][0]["dateTime"]);

      // parsedDate.weekday - 1 because, the weekdays are numbered
      // 1 - 7 // starting at monday to sunday
      // so in order to account for index 0 of dayConstants List, thats why
      var date = "${parsedDate.month}/${dayConstants[parsedDate.weekday - 1]} ${parsedDate.day}/${parsedDate.year}";

      var todoMetaData = {"date": date, "todos": noOfTodos, "completed": noOfCompleted};

      allTodos[i].insert(0, todoMetaData);
    }

    return allTodos;
  }

  // Function to handle the saving of todos
  void handleSavingOfTodo(Map newTodo) {
    // convert the docket List to just a 1-D list of all todos
    var allTodos = handleConvertingDocketListTo1DListOfTodos();

    // add new todo
    allTodos.add(newTodo);

    // sort all todos
    allTodos = handleSortingOfTodoList(allTodos);

    // seperate todos into sub lists creating the 2-D list again
    allTodos = handleSeperationOfTodosBasedOnDate(allTodos);

    // inject meta data into each sub list of todo list
    allTodos = handleInjectionOfMetaDataIntoEachSubList(allTodos);

    // setState for the docket list
    setState(() {
      docketList = allTodos;
    });
  }

  bool handleCheckIfDayHasPassed(List<DateTime> dates) {
    var currentDate = dates[0];
    var docketDate = dates[1];

    if((currentDate.year == docketDate.year) && (currentDate.month == docketDate.month) && (currentDate.day == docketDate.day)) {
      return false; // day has NOT passed
    }

    return true; // day has passed
  }

  void handleShowInfoAlertDialog(Map metaData) {
    var todos = metaData["todos"];
    var completed = metaData["completed"];

    String text;

    if(completed == 0) {
      text = "You created $todos ${todos == 1? 'todo' : 'todos'}, and you completed none.";
    }else if(todos > completed) {
      text = "You created $todos ${todos == 1? 'todo' : 'todos'}, and you were able to complete $completed. Good Job✌🏾";
    }else {
      text = "You created $todos ${todos == 1? 'todo' : 'todos'}, and you completed all. I am super proud of you Champ! Good Job.✌🏾";
    }

    showDialog(
      context: context,
      builder: (context) => InfoAlertDialog(
        type: Types.info,
        text: "The day has passed for this docket, so changes can't be made anymore! $text",
        ok: () => Navigator.of(context).pop(),
      ),
    );
  }

  // Function to handle the checking of a todo checkbox
  void handleTodoCheckboxChange(List indexes) {
    // check if day has passed
    var docket = docketList[indexes[0]];
    var docketObject = docket[indexes[1]];

    var hasDayPassed = handleCheckIfDayHasPassed([DateTime.now(), DateTime.parse(docketObject["dateTime"])]);

    if(hasDayPassed) {
      handleShowInfoAlertDialog(docket[0]);
      return;
    }

    // set state if day has not passed
    setState(() {
      docketList[indexes[0]][indexes[1]]["todoCompleted"] = !docketList[indexes[0]][indexes[1]]["todoCompleted"];

      // recalculate number of completed todo in docket
      int noOfCompletedTodo = 0;
      for(var i = 1; i < docketList[indexes[0]].length; i++) {
        if(docketList[indexes[0]][i]["todoCompleted"]) {
          noOfCompletedTodo++;
        }
      }
      docketList[indexes[0]][0]["completed"] = noOfCompletedTodo;
    });

    // update database
    updateDB(docketList);
  }

  // Function to handle the deleting of a todo
  void handleDeletingOfOneTodo(List indexes) {
    // check if day has passed
    var docket = docketList[indexes[0]];
    var docketObject = docket[indexes[1]];

    var hasDayPassed = handleCheckIfDayHasPassed([DateTime.now(), DateTime.parse(docketObject["dateTime"])]);

    if(hasDayPassed) {
      handleShowInfoAlertDialog(docket[0]);
      return;
    }

    setState(() {
      docketList[indexes[0]].removeAt(indexes[1]);

      // recalculate number of todos left, but if parentIndex docket contains 
      // only one item, then remove it
      if(docketList[indexes[0]].length == 1) {
        docketList.removeAt(indexes[0]);
        return;
      } else {
        docketList[indexes[0]][0]["todos"] = docketList[indexes[0]].length - 1;
      }

      // recalculate number of completed todo in docket
      int noOfCompletedTodo = 0;
      for(var i = 1; i < docketList[indexes[0]].length; i++) {
        if(docketList[indexes[0]][i]["todoCompleted"]) {
          noOfCompletedTodo++;
        }
      }
      docketList[indexes[0]][0]["completed"] = noOfCompletedTodo;
    });

    // update database
    updateDB(docketList);
  }

  // Function to handle deleting of a docket, not all the dockets, just one
  void handleDeletingOfADocket(int parentIndex) {
    setState(() {
      docketList.removeAt(parentIndex);
    });
    Navigator.of(context).pop();

    // update database
    updateDB(docketList);
  }

  // Function to show the dialog confirming if the user still wants to delete the docket, not all dockets, just that one.
  void handleShowDeleteADocketDialogBox(int parentIndex) {
    showDialog(
      context: context,
      builder: (context) => InfoAlertDialog(
        type: Types.danger,
        text: "Are you sure you want to delete the docket for ${docketList[parentIndex][0]['date']}?",
        ok: () => handleDeletingOfADocket(parentIndex)
      ),
    );
  }

}