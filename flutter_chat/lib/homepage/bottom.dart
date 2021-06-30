import 'package:flutter/material.dart';

class Bottom {
  int _selectedIndex = 0;
  Bottom() {}
  void _onItemTapped(int index) {}
  BottomNavigationBar bottomNavigationBar() => BottomNavigationBar(
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
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline,
              color: Colors.black,
            ),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.child_care_outlined,
              color: Colors.black,
            ),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            label: "Me",
          ),
        ],
      );
}
