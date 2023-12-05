//? Author: Enoch Enujiugha aka theNaijaDeveloper😀😎💚

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import "package:docket/pages/home_page.dart";
import "package:docket/pages/about_page.dart";

void main() {
  runApp(const DocketApp());
}

class DocketApp extends StatelessWidget {
  const DocketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

        primarySwatch: Colors.orange, // not working, not sure why
        highlightColor: Colors.orange[700],
        scaffoldBackgroundColor: Colors.orange[100],
      ),
    );
  }
}
