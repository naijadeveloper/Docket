// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
import "package:docket/functions/home_page_funtions.dart";
import "package:docket/data/local_db.dart";
import "package:docket/sections/home_page_sections/no_docket.dart";
import "package:docket/sections/home_page_sections/list_dockets.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // def all needed props
  final localdb = LocalDB();
  late final Box<dynamic> docketBox;
  late final HomeFunctions homeFunctions;

  @override
  void initState() {
    super.initState();

    // initialse docketbox
    docketBox = localdb.docketBox;

    // initialise the home functions to get access to the context and setState
    homeFunctions = HomeFunctions(
      context: context,
      setState: setState,
      dockets: localdb.loadData,
      updateDB: localdb.updateDatabase
    );

    // if first time opening app create initial data
    if(docketBox.get("DOCKETLIST") == null) {
      var newTodo = {"todoName": "Slide to delete a todo", "todoCompleted": false, "dateTime": DateTime.now().toString()};

      homeFunctions.handleSavingOfTodo(newTodo);
    } else {
      homeFunctions.docketList = localdb.loadData;
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Docket",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/about_page");
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.info),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: homeFunctions.handleFloatingBtnClicked,
        child: Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: homeFunctions.docketList.isEmpty? 
          NoDocket() : ListDockets(
            docketList: homeFunctions.docketList,

            handleTodoCheckboxChange: homeFunctions.handleTodoCheckboxChange,

            handleDeletingOfOneTodo: homeFunctions.handleDeletingOfOneTodo,

            handleShowDeleteADocketDialogBox: homeFunctions.handleShowDeleteADocketDialogBox,

            handleCheckIfDayHasPassed: homeFunctions.handleCheckIfDayHasPassed,
          ),
      ),
    );
  }
}