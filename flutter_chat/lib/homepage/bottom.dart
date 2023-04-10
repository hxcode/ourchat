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
      );
}
