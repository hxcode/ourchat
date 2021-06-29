import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
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
        trailing: Text(
          '18:30',
          style: TextStyle(color: Colors.grey),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _tile('Ivy', '85 W Portal Ave', Icons.person),
        _tile('Oliver ', '272 Claremont Blvd', Icons.person),
        _tile('Kobe', '429 Castro St', Icons.person),
        _tile('James', '2550 Mission St', Icons.person),
        _tile('curry', '3117 16th St', Icons.person),
        _tile('durant', '501 Buckingham Way', Icons.person),
        _tile('Jordan', '135 4th St #3000', Icons.person),
        _tile('sara', '757 Monterey Blvd', Icons.person),
        _tile('turk', '1923 Ocean Ave', Icons.person),
        _tile('Davis', '291 30th St', Icons.person),
      ],
    );
  }
}
