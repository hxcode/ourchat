import 'package:flutter/material.dart';

class Bottom {
  Bottom() {}

  Widget listBottom() => Container(
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
                Icon(Icons.child_care_outlined),
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
      );
}
