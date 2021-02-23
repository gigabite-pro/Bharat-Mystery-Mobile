import 'package:flutter/material.dart';

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
                onPressed: () {},
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
