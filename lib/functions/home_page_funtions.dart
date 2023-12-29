
// ignore_for_file: unnecessary_getters_setters, prefer_const_constructors

import "package:flutter/material.dart";
import "package:docket/components/create_todo_alert_dialog.dart";
import "package:docket/components/show_info_alert_dialog.dart";

mixin HomeFunctions {

  void handleFloatingBtnClicked(BuildContext context) async{
    await showDialog(
      context: context, 
      builder: (context) => CreateTodoDialog(),
    );
  }


  void handleShowInfoAlertDialog(BuildContext context, int docketIndex) {
    showDialog(
      context: context,
      builder: (context) => InfoAlertDialog(
        type: Types.info,
        docketIndex: docketIndex
      ),
    );
  }


  void handleShowDeleteADocketAlertDialog(BuildContext context, int docketIndex) {
    showDialog(
      context: context,
      builder: (context) => InfoAlertDialog(
        type: Types.danger,
        docketIndex: docketIndex,
      ),
    );
  }

}