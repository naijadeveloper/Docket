
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:docket/providers/dockets_provider.dart";
import "package:docket/components/todo_tile.dart";
import "package:docket/state/docket_model.dart";
import "package:docket/functions/home_page_funtions.dart";

class ListDockets extends ConsumerWidget with HomeFunctions {
  const ListDockets({super.key});

  void handleTodoTileOnChanged(int docketIndex, int todoIndex, BuildContext context, WidgetRef ref) {
    var res = ref.read(docketsProvider.notifier).toggle(docketIndex: docketIndex, todoIndex: todoIndex);
    if(res == false) {
      // show info dialog, tells user that the day for docket has passed
      handleShowInfoAlertDialog(context, docketIndex);
    }
  }


  void handleTodoTileDelete(int docketIndex, int todoIndex, BuildContext context, WidgetRef ref) {
    var res = ref.read(docketsProvider.notifier).deleteATodo(docketIndex: docketIndex, todoIndex: todoIndex);
    if(res == false) {
      // show info dialog, tells user that the day for docket has passed
      handleShowInfoAlertDialog(context, docketIndex);
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Docket> docketList = ref.watch(docketsProvider);
    
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      itemCount: docketList.length,
      itemBuilder: (context, docketIndex) {

        if(docketList.isEmpty) return SizedBox();
        
        var docket = docketList[docketIndex];
        var todos = docket.todos;
        var isDocketForToday = docket == ref.read(docketsProvider.notifier).todayDocket()? true : false;

        var allWidgetsInADocket = List<Widget>.generate(todos.length, (todoIndex) {

          if(todoIndex == 0) {
            // when its the 0th index return both the formatted meta data widgets and the todo
            // but for for consequent indexes return only the todo
            var formattedMetaData = docket.formattedMetaData();
            return Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Text("${formattedMetaData['date']}",
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
                            Text("(${formattedMetaData['todos']}) ${formattedMetaData['todos'] == 1? 'Todo' : 'Todos'}",
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
                
                              Text("Completed (${formattedMetaData['completed']})",
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
                        onTap: () => handleShowDeleteADocketAlertDialog(context, docketIndex),
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ]
                ),

                TodoTile(
                  enabled: isDocketForToday,
                  todoName: todos[todoIndex].todoName, 
                  todoCompleted: todos[todoIndex].todoCompleted, 
                  onChanged: () => handleTodoTileOnChanged(docketIndex, todoIndex, context, ref), 
                  deleteTodo: () => handleTodoTileDelete(docketIndex, todoIndex, context, ref),
                )
              ],
            );

          } else {
            return TodoTile(
              enabled: isDocketForToday,
              todoName: todos[todoIndex].todoName, 
              todoCompleted: todos[todoIndex].todoCompleted, 
              onChanged: () => handleTodoTileOnChanged(docketIndex, todoIndex, context, ref), 
              deleteTodo: () => handleTodoTileDelete(docketIndex, todoIndex, context, ref),
            );
          }
        });

        // returned container for each docket
        return Container(
          margin: docketIndex == 0? EdgeInsets.only(top: 10) : EdgeInsets.only(top: 40),
          child: Column(
            children: allWidgetsInADocket,
          ),
        );
      },
    );
  }
}