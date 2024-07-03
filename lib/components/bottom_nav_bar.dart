import 'dart:async';
import 'package:flutter/material.dart';
import 'package:real_estate_app/screens/home.dart';
import 'package:real_estate_app/screens/map_screen.dart';
import 'package:real_estate_app/screens/settings.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    SettingsScreen(),
  ];

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  bool _isNavBarVisible = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    Timer(Duration(seconds: 2), () {
      setState(() {
        _isNavBarVisible = true;
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: _isNavBarVisible
          ? SlideTransition(
              position: _offsetAnimation,
              child: Container(
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BottomNavigationBar(
                  // backgroundColor: Colors.transparent,
                  backgroundColor: Color(0x00ffffff),
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, color: Colors.white),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person, color: Colors.white),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings, color: Colors.white),
                      label: 'Settings',
                    ),
                  ],
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.white,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
