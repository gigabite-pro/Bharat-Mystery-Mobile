import 'package:bharat_mystery/screens/monument.dart';
import 'package:bharat_mystery/screens/profile.dart';
import 'package:bharat_mystery/screens/selectMonument.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key pagekey, this.title}) : super(key: pagekey);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    //exit app on back pressed
    return WillPopScope(onWillPop: _onWillPop, child: Home());
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
