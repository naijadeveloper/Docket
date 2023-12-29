// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:docket/providers/dockets_provider.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

enum Types {
  danger,
  info,
}

class InfoAlertDialog extends ConsumerWidget {
  const InfoAlertDialog({
    super.key,
    required this.type,
    required this.docketIndex
  });

  final Types type;
  final int docketIndex;

  String congratsText(int noOfCompletedTodos, int noOfTodos) {
    if(noOfCompletedTodos == 0) {
      return "You created $noOfTodos ${noOfTodos == 1? 'todo' : 'todos'}, and you completed none.";
    } else if(noOfCompletedTodos < noOfTodos) {
      return "You created $noOfTodos ${noOfTodos == 1? 'todo' : 'todos'}, and you were able to complete $noOfCompletedTodos. Good Job✌🏾";
    }else {
      return "You created $noOfTodos ${noOfTodos == 1? 'todo' : 'todos'}, and you completed all. I am super proud of you Champ! Good Job.✌🏾";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dockets = ref.watch(docketsProvider);
    
    if(dockets.isEmpty) return SizedBox();

    var docket = dockets[docketIndex];
    var text = congratsText(docket.formattedMetaData()["completed"] as int, docket.formattedMetaData()["todos"] as int);

    return AlertDialog(
      backgroundColor: Colors.grey.shade800,
      insetPadding: EdgeInsets.all(30),
      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
      elevation: 0,

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(type == Types.danger? "Are you sure you want to delete the docket for ${docket.formattedMetaData()['date']}" 
            : "The day has passed for this docket, so changes can't be made anymore! $text",
            style: TextStyle(
              color: Colors.grey.shade200,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              onPressed: () {
                if(type == Types.danger) {
                  // delete docket
                  ref.read(docketsProvider.notifier).deleteADocket(docketIndex);
                }

                // pop out widget
                Navigator.of(context).pop();
              },
              elevation: 0,
              highlightElevation: 0,
              textColor: Colors.grey.shade200,
              color: type == Types.danger? Colors.red.shade800 : Colors.grey.shade600,
              highlightColor: type == Types.danger? Colors.red.shade700 : Colors.grey.shade700,
              child: Text(type == Types.danger? 'Yes' : 'Ok',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}