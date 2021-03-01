import 'package:bharat_mystery/screens/login.dart';
import 'package:bharat_mystery/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: CachedNetworkImage(
                        imageUrl: "https://i.imgur.com/W0fE4FL.png",
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
                              builder: (BuildContext context) => RegisterPage(),
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
                              builder: (BuildContext context) => LoginPage(),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
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
    );
  }
}
