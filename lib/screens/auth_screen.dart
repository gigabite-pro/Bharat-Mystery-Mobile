import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                color: Color(0xffA0E7E5),
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
                        Navigator.of(context).pushNamed('/register-page');
                      },
                      color: Colors.black,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
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
                        Navigator.of(context).pushNamed('/login-page');
                      },
                      color: Colors.black,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
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
