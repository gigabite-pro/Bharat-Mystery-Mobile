import 'package:bharat_mystery/screens/login.dart';
import 'package:bharat_mystery/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String uid;
  @override
  void initState() {
    super.initState();
    _asyncMethodInnitState();
  }

  //god this was hell, wasted like 3 hours, trying to update the name of the user, after welcome.
  void _asyncMethodInnitState() async {
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('GLOBAL_USER_DATA');
    if (uid != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100.0, 0, 40.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: CachedNetworkImage(
                            imageUrl: "https://i.imgur.com/9JCxapv.png",
                            height: MediaQuery.of(context).size.height * 0.27,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          "Bharat Mystery",
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 30.0,
                            fontFamily: 'LexendDeca',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        MaterialButton(
                          splashColor: Colors.white,
                          height: 50.0,
                          padding: EdgeInsets.symmetric(horizontal: 43.0),
                          elevation: 10.0,
                          shape: StadiumBorder(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterPage(),
                                ));
                          },
                          color: Theme.of(context).highlightColor,
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        MaterialButton(
                          splashColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 53.0),
                          height: 50.0,
                          elevation: 10.0,
                          shape: StadiumBorder(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage(),
                                ));
                          },
                          color: Theme.of(context).highlightColor,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60.0, 0, 40.0),
                child: Text(
                  "*Amity International School, Sector-46",
                  style: TextStyle(
                    fontFamily: 'LexendDeca',
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
