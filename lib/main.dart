//? Author: Enoch Enujiugha aka theNaijaDeveloper😀😎💚

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:hive_flutter/hive_flutter.dart";
import "package:docket/pages/home_page.dart";
import "package:docket/pages/about_page.dart";

void main() async {
  // initialise app with hive
  await Hive.initFlutter();

  // open a box(i.e collection)
  await Hive.openBox("docketBox");

  runApp(
    ProviderScope(
      child: DocketApp(),
    ),
  );
}

class DocketApp extends StatelessWidget {
  const DocketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: "Docket",

      home: HomePage(),

      routes: {
        "/about_page": (context) => AboutPage(),
      },

      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          elevation: 0,
          centerTitle: true,
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
          elevation: 0,
          highlightElevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
        ),

        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),

        primarySwatch: Colors.orange, // not working, not sure why
        highlightColor: Colors.orange[700],
        scaffoldBackgroundColor: Colors.orange[100],
      ),
    );
  }
}
