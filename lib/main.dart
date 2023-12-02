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
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange[100],
      ),
      routes: {
        "/about_page": (context) => AboutPage(),
      },
    );
  }
}
