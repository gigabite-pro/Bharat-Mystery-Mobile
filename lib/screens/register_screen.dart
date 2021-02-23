import 'package:bharat_mystery/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegisterContent());
  }
}

class RegisterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  //logo and bharat mystery text
                  children: [
                    //logo bharat mystery
                    Container(
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    //text bharat mystery
                    Text(
                      "Bharat Mystery",
                      style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffA0E7E5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    //register text
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            autocorrect: false,
                            autofocus: false,
                            decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[50]),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                contentPadding: EdgeInsets.all(20.0)),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          //email
                          TextField(
                            autocorrect: false,
                            autofocus: false,
                            decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[50]),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                contentPadding: EdgeInsets.all(20.0)),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          //password
                          TextField(
                            autocorrect: false,
                            autofocus: false,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[50]),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                contentPadding: EdgeInsets.all(20.0)),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            //already have an account login --useless
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginPage()));
                                  },
                                  child: Text(
                                    "Already have an account? Login",
                                    style: TextStyle(
                                      fontFamily: 'LexendDeca',
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),

                    //register button
                    MaterialButton(
                      onPressed: () {},
                      height: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      shape: StadiumBorder(),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontFamily: 'LexendDeca',
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
