import 'package:flutter/material.dart';

class ChatBar {
  String title;

  ChatBar(this.title) {}

  AppBar buildAppbar() => AppBar(
        centerTitle: true,
        toolbarHeight: 48.0,
        backgroundColor: Colors.white70,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            letterSpacing: 0.5,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline_rounded),
            onPressed: () {},
          ),
        ],
      );
}
