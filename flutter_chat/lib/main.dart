import 'package:flutter/material.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 48.0,
        backgroundColor: Colors.white70,
        title: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              // padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: ListView(
                children: [
                  _tile('Oliver', '85 W Portal Ave', Icons.person),
                  _tile('Kobe', '429 Castro St', Icons.person),
                  _tile('James', '2550 Mission St', Icons.person),
                  _tile('curry', '3117 16th St', Icons.person),
                  _tile('durant', '501 Buckingham Way', Icons.person),
                  _tile('Jordan', '135 4th St #3000', Icons.person),
                  Divider(),
                  _tile('cart', '757 Monterey Blvd', Icons.person),
                  _tile('turk', '1923 Ocean Ave', Icons.person),
                  _tile('burd ', '272 Claremont Blvd', Icons.person),
                  _tile('Davis', '291 30th St', Icons.person),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.message),
                      Text('Chats'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.people),
                      Text('Contacts'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.play_circle),
                      Text('Discover'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.person),
                      Text('Me'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
