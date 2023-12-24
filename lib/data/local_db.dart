import "package:flutter/material.dart";
import 'package:docket/state/docket_model.dart';
import "package:hive_flutter/hive_flutter.dart";

@immutable
class LocalDB {
  //ref to box
  final docketBox = Hive.box("docketBox");

  // load data from db
  List<Docket> get loadData => docketBox.get("DOCKETLIST", defaultValue: []);

  // update the database
  void updateDatabase(List docketList) {
    docketBox.put("DOCKETLIST", docketList);
  }
}