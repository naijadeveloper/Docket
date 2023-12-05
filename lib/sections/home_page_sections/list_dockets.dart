
// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class ListDockets extends StatelessWidget {
  const ListDockets({super.key});

  static const listing = [1,2,4,5];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listing.length,
      itemBuilder: (context, index) {
        return SizedBox(child: Text("$index"));
      },
    );
  }
}