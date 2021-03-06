import 'package:flutter/material.dart';
import 'package:flutter_chat/homepage/bottom.dart';
import 'package:flutter_chat/homepage/appbar.dart';
import 'package:flutter_chat/homepage/chats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OurChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white70,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: MyHomePage(title: 'OurChat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var chatBar = ChatBar(widget.title);
    var bottom = Bottom();
    return Scaffold(
      appBar: chatBar.buildAppbar(),
      body: Center(
        child: Chats(),
      ),
      bottomNavigationBar: bottom.bottomNavigationBar(),
    );
  }
}
