import 'package:bharat_mystery/screens/monument.dart';
import 'package:bharat_mystery/screens/profile.dart';
import 'package:bharat_mystery/screens/selectMonument.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    SelectMonument(),
    Monument(),
    Profile(),
  ];

  void _itemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _itemTapped,
        backgroundColor: Color(0xffA0E7E5),
        animationDuration: Duration(milliseconds: 1000),
        animationCurve: Curves.fastLinearToSlowEaseIn,
        height: 52.0,
        items: <Widget>[
          Icon(
            Icons.info,
            size: 30.0,
            color: Colors.black,
          ),
          Icon(
            Icons.location_on,
            size: 20.0,
            color: Colors.black,
          ),
          Icon(
            Icons.settings,
            size: 20.0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
