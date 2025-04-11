import 'package:flutter/material.dart';

import 'audio_screen.dart';
import 'form_screen.dart';
import 'home_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int selectedIndex = 0;

  List <Widget> screens = [
    const HomeScreen(),
    const AudioScreen(),
    const FormScreen(),
  ];

  void onTap(int newIndex){
    setState(() {
      selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF10141E),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Movies"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.headphones),
              label: "Music"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account"
          )
        ],
        onTap: (idx) => onTap(idx),
        currentIndex: selectedIndex,
      ),
    );
  }
}
