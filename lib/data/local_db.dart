import "package:docket/state/todo_model.dart";
import "package:flutter/material.dart";
import 'package:docket/state/docket_model.dart';
import "package:hive_flutter/hive_flutter.dart";

@immutable
class LocalDB {
  //ref to box
  final docketBox = Hive.box("docketBox");

  // load data from db
  List<Docket>? get loadData {
    var savedTodos = docketBox.get("DOCKETLIST");
    if(savedTodos == null) return null;

    return Docket.generateListOfDockets(savedTodos);
  }

  // update the database
  void updateDatabase(List<Todo> docketList) {
    docketBox.put("DOCKETLIST", docketList);
  }
}