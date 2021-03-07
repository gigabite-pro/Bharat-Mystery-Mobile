import 'package:bharat_mystery/screens/homepage.dart';
import 'package:bharat_mystery/screens/selectMonument.dart';
import 'package:bharat_mystery/screens/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login.dart';
import 'screens/forgot.dart';
import 'screens/register.dart';
import 'screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// ignore: avoid_init_to_null
String uid = null;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  uid = prefs.getString('GLOBAL_USER_DATA');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
              title: "Bharat Mystery",
              theme: notifier.darkTheme ? dark : light,
              initialRoute: '/',
              routes: {
                '/': (_) => Wrapper(),
                '/login-page': (_) => LoginPage(),
                '/auth-screen': (_) => AuthScreen(),
                '/register-page': (_) => RegisterPage(),
                '/home-page': (_) => HomePage(),
                '/forgot-password-page': (_) => ForgotPage(),
                '/select-monument': (_) => SelectMonument()
              });
        },
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //On App start, if user logged in, show HomePage page, else show AuthScreen
    if (uid != null) {
      return HomePage();
    }
    return AuthScreen();
  }
}
