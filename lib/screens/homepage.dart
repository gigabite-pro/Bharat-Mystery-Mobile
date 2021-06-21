import 'package:bharat_mystery/screens/profile.dart';
import 'package:bharat_mystery/screens/selectMonument.dart';
import 'package:bharat_mystery/screens/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    SelectMonument(),
    Profile(),
  ];

  void _itemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: Scaffold(
              body: PageView(
                controller: _pageController,
                children: _screens,
                physics: NeverScrollableScrollPhysics(),
              ),
              bottomNavigationBar: CurvedNavigationBar(
                color: Theme.of(context).cardColor,
                onTap: _itemTapped,
                backgroundColor: Theme.of(context).focusColor,
                animationDuration: Duration(milliseconds: 1000),
                animationCurve: Curves.fastLinearToSlowEaseIn,
                height: 52.0,
                items: <Widget>[
                  Icon(
                    Icons.info,
                    size: 20.0,
                    color: Theme.of(context).highlightColor,
                  ),
                  Icon(
                    Icons.settings,
                    size: 20.0,
                    color: Theme.of(context).highlightColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
