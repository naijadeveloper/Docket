
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:docket/components/todo_tile.dart";

class ListDockets extends StatelessWidget {
  const ListDockets({
    super.key,
    required this.docketList,
    required this.handleShowDeleteAllDialogBox,
    required this.handleTodoCheckboxChange,
    required this.handleDeletingOfOneTodo,
  });

  final List docketList;
  final void Function(int) handleShowDeleteAllDialogBox;
  final void Function(List<int>) handleTodoCheckboxChange;
  final void Function(List<int>) handleDeletingOfOneTodo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: docketList.length,
      itemBuilder: (context, parentIndex) {
        var docket = docketList[parentIndex];

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
                  top: 20,
                  right: 30,
                  child: GestureDetector(
                    onTap: () => handleShowDeleteAllDialogBox(parentIndex),
                    child: Icon(Icons.delete),
                  ),
                ),
              ]
            );

          } else {/////////////////////////////////////////
            return TodoTile(
              todoName: docket[childIndex]["todoName"], 
              todoCompleted: docket[childIndex]["todoCompleted"], 
              onChanged: () => handleTodoCheckboxChange([parentIndex, childIndex]), 
              deleteTodo: () => handleDeletingOfOneTodo([parentIndex, childIndex]),
            );
          }
        });

        // returned container for each docket
        return Container(
          margin: parentIndex == 0? EdgeInsets.only(top: 12) : EdgeInsets.only(top: 40),
          child: Column(
            children: allWidgetsInADocket,
          ),
        );
      },
    );
  }
}