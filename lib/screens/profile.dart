import 'package:bharat_mystery/main.dart';
import 'package:bharat_mystery/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xffA0E7E5),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 300.0, 20.0, 0),
          child: Column(
            children: <Widget>[
              Text(
                "Welcome User",
                style: TextStyle(
                  fontFamily: 'LexendDeca',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: logout_user,
                height: 50.0,
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                shape: StadiumBorder(),
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontFamily: 'LexendDeca',
                      fontSize: 16.0,
                      color: Colors.white),
                ),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout_user() async {
    //TODO: logout user
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('GLOBAL_USER_DATA', null);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ));
  }

  @override
  //TODO: implement want Keep Alive
  bool get wantKeepAlive => true;
}
