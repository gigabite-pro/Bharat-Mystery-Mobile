import 'package:bharat_mystery/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/forgot.dart';
import 'screens/register_screen.dart';
import 'screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uid = null;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  uid = prefs.getString('GLOBAL_USER_DATA');
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
          '/login-page': (_) => LoginPage(),
          '/auth-screen': (_) => AuthScreen(),
          '/register-page': (_) => RegisterPage(),
          '/home-page': (_) => HomePage(),
          '/forgot-password-page': (_) => ForgotPage()
        });
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //On App start, if user logged in, show Monuments page, else show AuthScreen
    if (uid != null) {
      return HomePage();
    }
    return AuthScreen();
  }
}
