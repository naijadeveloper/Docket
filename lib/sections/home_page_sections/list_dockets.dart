
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/*
  [ // docket list
    [ // parentIndex // one docket
      {date: "12/Wednesday 6/2023", todos: 2, completed: 1}, // 0th childIndex is metadata
      {todoName: "do blah blah", todoCompleted: false, dateTime: "2023-12-06 16:51:54.417"}
      {todoName: "do another blah blah", todoCompleted: true, dateTime: "2023-12-06 18:51:54.417"}
    ]
  ]
*/

import "package:flutter/material.dart";
import "package:docket/components/todo_tile.dart";

class ListDockets extends StatelessWidget {
  const ListDockets({
    super.key,
    required this.docketList,
    required this.handleShowDeleteADocketDialogBox,
    required this.handleTodoCheckboxChange,
    required this.handleDeletingOfOneTodo,
    required this.handleCheckIfDayHasPassed,
  });

  final List docketList;
  final void Function(int) handleShowDeleteADocketDialogBox;
  final void Function(List<int>) handleTodoCheckboxChange;
  final void Function(List<int>) handleDeletingOfOneTodo;
  final bool Function(List<DateTime>) handleCheckIfDayHasPassed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      itemCount: docketList.length,
      itemBuilder: (context, parentIndex) {
        
        var docket = docketList[parentIndex];
        var hasDayPassed = handleCheckIfDayHasPassed([DateTime.now(), DateTime.parse(docket[1]["dateTime"])]); // compare dates, if same => false; else => true;

        var allWidgetsInADocket = List<Widget>.generate(docket.length, (childIndex) {

          if(childIndex == 0) {/////////////////////////////////////////
            return Stack(
              children: [
                Column(
                  children: [
                    Text(docket[childIndex]["date"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                        fontSize: 16, 
                      ),
                    ),

                    SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("(${docket[childIndex]['todos']}) ${docket[childIndex]['todos'] == 1? 'Todo' : 'Todos'}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.orange[800]
                          ),
                        ),

                        SizedBox(width: 3),

                          Text("|",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(width: 3),

                          Text("Completed (${docket[childIndex]['completed']})",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green[500]
                            ),
                          ),
                      ],
                    ),
                  ]
                ),

                Positioned(
                  top: 25,
                  right: 25,
                  child: GestureDetector(
                    onTap: () => handleShowDeleteADocketDialogBox(parentIndex),
                    child: Icon(Icons.delete),
                  ),
                ),
              ]
            );

          } else {/////////////////////////////////////////
            return TodoTile(
              enabled: !hasDayPassed,// when current day is same as docket day => true
              todoName: docket[childIndex]["todoName"], 
              todoCompleted: docket[childIndex]["todoCompleted"], 
              onChanged: () => handleTodoCheckboxChange([parentIndex, childIndex]), 
              deleteTodo: () => handleDeletingOfOneTodo([parentIndex, childIndex]),
            );
          }
        });

        // returned container for each docket
        return Container(
          margin: parentIndex == 0? EdgeInsets.only(top: 10) : EdgeInsets.only(top: 40),
          child: Column(
            children: allWidgetsInADocket,
          ),
        );
      },
    );
  }
}