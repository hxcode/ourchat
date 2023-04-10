import 'package:flutter/material.dart';
import 'package:flutter_chat/homepage/appbar.dart';
import 'package:flutter_chat/homepage/chats.dart';
import 'package:flutter_chat/util/filePicker.dart';
import 'package:flutter_chat/util/sqlitedb.dart';

void main() {
  // GlobalDb.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '数据浏览',
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
      home: MyHomePage(title: '数据浏览'),
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
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Chats(),
    ExcelFilePicker(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var chatBar = ChatBar(widget.title);
    return Scaffold(
      appBar: chatBar.buildAppbar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_outlined,
              color: Colors.black,
            ),
            label: "人才",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline,
              color: Colors.black,
            ),
            label: "上传",
          ),
        ],
      ),
    );
  }
}
