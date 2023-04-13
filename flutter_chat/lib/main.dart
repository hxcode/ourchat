import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_chat/homepage/person.dart';
import 'package:flutter_chat/util/filePicker.dart';

void main() {
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
  String selectedCondtion = '';
  String searchValue = '';
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      searchValue = '';
      selectedCondtion = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      NbPerson(
        searchValue: this.searchValue,
        selectedCondition: this.selectedCondtion,
      ),
      ExcelFilePicker(),
    ];
    return Scaffold(
      appBar: EasySearchBar(
        actions: [
          new DropdownButton<String>(
            value: selectedCondtion,
            items: <DropdownMenuItem<String>>[
              new DropdownMenuItem(
                child: new Text('全部条件'),
                value: '',
              ),
              new DropdownMenuItem(child: new Text('现居城市'), value: 'city'),
              new DropdownMenuItem(child: new Text('所属界别'), value: 'groupType'),
            ],
            onChanged: (String? value) {
              setState(() => selectedCondtion = (value as String));
            },
          )
        ],

        title: const Text('数据查看'),
        onSearch: (value) => setState(() => searchValue = value),
        // suggestions: _suggestions
      ),
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
