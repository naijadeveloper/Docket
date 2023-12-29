// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:docket/functions/home_page_funtions.dart";
import "package:docket/sections/home_page_sections/no_docket.dart";
import "package:docket/sections/home_page_sections/list_dockets.dart";
import "package:docket/state/docket_model.dart";
import "package:docket/providers/dockets_provider.dart";


class HomePage extends StatelessWidget with HomeFunctions {
  const HomePage({super.key});
  
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
        onPressed: () => handleFloatingBtnClicked(context),
        child: Icon(Icons.add),
      ),

      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          List<Docket> docketList = ref.watch(docketsProvider);

          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: docketList.isEmpty? 
              NoDocket() : ListDockets(),
          );
        }
      ),
    );
  }
}