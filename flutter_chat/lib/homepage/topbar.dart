import 'package:flutter/material.dart';

class ChatBar {
  String title;

  ChatBar(this.title) {}

  AppBar buildAppbar() => AppBar(
        centerTitle: true,
        toolbarHeight: 48.0,
        backgroundColor: Colors.white70,
        title: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
