import "package:hive_flutter/hive_flutter.dart";

class LocalDB {
  //ref to box
  var docketBox = Hive.box("docketBox");

  // load data from db
  List get loadData => docketBox.get("DOCKETLIST", defaultValue: []);

  // update the database
  void updateDatabase(List docketList) {
    docketBox.put("DOCKETLIST", docketList);
  }
}