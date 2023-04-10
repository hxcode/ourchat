import 'package:flutter/material.dart';

class NbPersonBar {
  String title;

  NbPersonBar(this.title) {}

  AppBar buildAppbar() => AppBar(
        toolbarHeight: 48.0,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          // IconButton(
          //   icon: Icon(Icons.add_circle_outline_rounded),
          //   onPressed: () {},
          // ),
        ],
      );
}
