import 'package:docket/state/docket_model.dart';
import 'package:docket/state/todo_model.dart';
import 'package:docket/data/local_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localdb = LocalDB();

class ListOfDocketsNotifier extends Notifier<List<Docket>> {
  // We initialize the list of dockets to an empty list
  @override
  List<Docket> build() {
    if(localdb.loadData == null) {
      // build init todo
      return [Docket(todos: [
        Todo(
          todoName: "Slide to delete a todo",
          todoCompleted: false,
          dateTime: DateTime.now().toString(),
        ),
      ])];
    } else {
      // return existing list of dockets
      return localdb.loadData!;
    }
  }


  void addTodo(Todo todo) {
    // If no docket exist for the current day, then create a docket
    // and add to it, otherwise
    // Get the docket for the current day and add the todo to it
    var currentDocket = todayDocket();
    if(currentDocket == null) {
      // Create new docket and add the todo to it
      state = [Docket(todos: [todo]), ...state];
    } else {
      // Add todo to existing docket
      var todos = [...currentDocket.todos, todo];

      state = [
        for(final docket in state)
          if(docket == currentDocket)
            docket.copyWith(todos)
          else
            docket
      ];
    }

    //sort docket list
    sortDocketList();

    //save to database
    var allTodos = [
      for(final docket in state)
        ...docket.todos
    ];
    localdb.updateDatabase(allTodos);
  }


  // when the checkbox is clicked
  bool toggle({required int docketIndex, required int todoIndex}) {
    var theDocket = state[docketIndex];
    var theTodo = theDocket.todos[todoIndex];

    //prevent toggle if day has passed
    var currentDocket = todayDocket();
    if(currentDocket != theDocket) return false;
    //

    var todos = [
      for(final aTodo in theDocket.todos)
        if(aTodo == theTodo)
          aTodo.copyWith(todoCompleted: !aTodo.todoCompleted)
        else
          aTodo
    ];

    state = [
      for(final aDocket in state)
        if(aDocket == theDocket)
          aDocket.copyWith([...todos])
        else
          aDocket
    ];

    //save to database
    var allTodos = [
      for(final docket in state)
        ...docket.todos
    ];
    localdb.updateDatabase(allTodos);

    return true;
  }


  bool deleteATodo({required int docketIndex, required int todoIndex}) {
    var theDocket = state[docketIndex];
    var theTodo = theDocket.todos[todoIndex];

    // prevent delete if day has passed
    var currentDocket = todayDocket();
    if(currentDocket != theDocket) return false;
    //

    var todos = [
      for(final aTodo in theDocket.todos)
        if(aTodo != theTodo) aTodo
    ];

    // if that is the last todo in docket then just remove the docket
    if(todos.isEmpty) {
      state = [
        for(final aDocket in state)
          if(aDocket != theDocket) aDocket
      ];
    } else {
      state = [
        for(final aDocket in state)
          if(aDocket == theDocket)
            aDocket.copyWith([...todos])
          else
            aDocket
      ];
    }
    
    //save to database
    var allTodos = [
      for(final docket in state)
        ...docket.todos
    ];
    localdb.updateDatabase(allTodos);

    return true;
  }


  void deleteADocket(int docketIndex) {
    if(state.isEmpty) return;
    
    var theDocket = state[docketIndex];

    state = [
      for(final aDocket in state)
        if(aDocket != theDocket) aDocket
    ];

    //save to database
    var allTodos = [
      for(final docket in state)
        ...docket.todos
    ];
    localdb.updateDatabase(allTodos);
  }


  void sortDocketList() {
    var theState = [...state];
    
    theState.sort((a,b) => b.dateMetaData()["day"]!.compareTo(a.dateMetaData()["day"]!));
    theState.sort((a,b) => b.dateMetaData()["month"]!.compareTo(a.dateMetaData()["month"]!));
    theState.sort((a,b) => b.dateMetaData()["year"]!.compareTo(a.dateMetaData()["year"]!));

    state = [...theState];
  }


  Docket? todayDocket() {
    var currentDateTime = DateTime.now();
    Docket? currentDocket;
    //
    for(final docket in state) {
      var parsedDateTime = docket.dateMetaData();

      if((currentDateTime.year == parsedDateTime["year"]) && 
      (currentDateTime.month == parsedDateTime["month"]) && 
      (currentDateTime.day == parsedDateTime["day"])) {
        //
        currentDocket = docket;
        //
      }
    }
    //
    return currentDocket;
  }

}