import 'package:bharat_mystery/screens/monument.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Bharat Mystery",
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => Wrapper(),
          '/auth-screen': (_) => AuthScreen(),
          '/login-page': (_) => LoginPage(),
          '/register-page': (_) => RegisterPage(),
          '/map': (_) => Map(),
          '/monument': (_) => Monument(),
        });
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //On App start, if user logged in, show Monuments page, else show AuthScreen
    return AuthScreen();
  }
}
