import 'package:docket/state/docket_model.dart';
import 'package:docket/state/todo_model.dart';
import 'package:docket/data/local_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localdb = LocalDB();

class ListOfDocketsNotifier extends Notifier<List<Docket>> {
  // We initialize the list of dockets to an empty list
  @override
  List<Docket> build() {
    return localdb.loadData;
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
    localdb.updateDatabase(state);
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
    localdb.updateDatabase(state);

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

    state = [
      for(final aDocket in state)
        if(aDocket == theDocket)
          aDocket.copyWith([...todos])
        else
          aDocket
    ];
    
    //save to database
    localdb.updateDatabase(state);

    return true;
  }


  void deleteADocket(int docketIndex) {
    var theDocket = state[docketIndex];

    state = [
      for(final aDocket in state)
        if(aDocket != theDocket) aDocket
    ];

    //save to database
    localdb.updateDatabase(state);
  }


  void sortDocketList() {
    var theState = [...state];
    
    theState.sort((a,b) => b.metaData()["day"]!.compareTo(a.metaData()["day"]!));
    theState.sort((a,b) => b.metaData()["month"]!.compareTo(a.metaData()["month"]!));
    theState.sort((a,b) => b.metaData()["year"]!.compareTo(a.metaData()["year"]!));

    state = [...theState];
  }


  bool isDocketListEmpty() {
    return state.isEmpty;
  }


  Docket? todayDocket() {
    var currentDateTime = DateTime.now();
    Docket? currentDocket;
    //
    for(final docket in state) {
      var parsedDateTime = docket.metaData();

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