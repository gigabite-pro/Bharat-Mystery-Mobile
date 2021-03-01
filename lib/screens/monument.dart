import 'dart:convert';
import 'package:bharat_mystery/screens/directions.dart';
import 'package:bharat_mystery/screens/streetview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong/latlong.dart';
import "package:flutter_tts/flutter_tts.dart";
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class Monument extends StatefulWidget {
  final int snumber;
  Monument({Key key, this.snumber}) : super(key: key);

  @override
  _MonumentState createState() => _MonumentState();
}

class _MonumentState extends State<Monument> {
  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) {
          Navigator.of(context).pop(true);
        });
  }

  @override
  Widget build(BuildContext context) {
    //exit app on back pressed
    return WillPopScope(
        onWillPop: _onWillPop,
        child: MonumentContent(
          snumber: widget.snumber,
        ));
  }
}

class MonumentContent extends StatefulWidget {
  final int snumber;
  MonumentContent({Key key, this.snumber}) : super(key: key);

  @override
  _MonumentContentState createState() => _MonumentContentState();
}

class _MonumentContentState extends State<MonumentContent> {
  Future<String> getMonument(int snumber) async {
    final getMonumentEndpoint =
        'https://bharat-mystery-api.herokuapp.com/monuments?sno=$snumber';
    final response = await http.get(getMonumentEndpoint);
    print(snumber);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return response.body;
    }
    return null;
  }

  final FlutterTts flutterTts = FlutterTts();
  Icon icon = Icon(Icons.volume_up, color: Colors.black);
  bool isSpeaking = false;

  var text = '';

  speak(text) async {
    await flutterTts.setLanguage('hi-IN');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.9);
    await flutterTts.speak(text);
    setState(() {
      if (isSpeaking == true) {
        flutterTts.stop();
        icon = Icon(Icons.volume_up, color: Colors.black);
        isSpeaking = false;
      } else {
        icon = Icon(Icons.volume_off, color: Colors.black);
        isSpeaking = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMonument(widget.snumber),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xffA0E7E5),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final result = json.decode(snapshot.data);

        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      height: MediaQuery.of(context).size.height * 0.83,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //image
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                              child: CachedNetworkImage(
                                imageUrl: result["image"].toString(),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),

                            //text
                            Text(
                              result["name"].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'LexendDeca',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              result["place"].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'LexendDeca',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Container(
                                  height: 180.0,
                                  child: FlutterMap(
                                    options: MapOptions(
                                      center: LatLng(result["latitude"],
                                          result["longitude"]),
                                      zoom: 13.0,
                                    ),
                                    layers: [
                                      TileLayerOptions(
                                        urlTemplate:
                                            "https://api.mapbox.com/styles/v1/chim2/ckleuvk5n65ak17pnwxgoyo7l/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2hpbTIiLCJhIjoiY2tsZXBjOWI1MTJvczJ2bWpiZWE5azNlNyJ9.-LB_CjjYIksqNZTdiSmFNg",
                                        additionalOptions: {
                                          // to be hidden later
                                          'accessToken':
                                              'pk.eyJ1IjoiY2hpbTIiLCJhIjoiY2tsZXBjOWI1MTJvczJ2bWpiZWE5azNlNyJ9.-LB_CjjYIksqNZTdiSmFNg',
                                          'id': ''
                                        },
                                      ),
                                      MarkerLayerOptions(
                                        markers: [
                                          Marker(
                                            width: 80.0,
                                            height: 80.0,
                                            point: LatLng(result["latitude"],
                                                result["longitude"]),
                                            builder: (ctx) => Container(
                                                child: Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),

                            //get directions button
                            MaterialButton(
                              splashColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 35.0),
                              height: 30.0,
                              elevation: 5.0,
                              shape: StadiumBorder(),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Directions(
                                              elong: result["longitude"],
                                              elat: result["latitude"]),
                                    ));
                              },
                              color: Colors.black,
                              child: Text(
                                "Get Directions",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),

                            //get street views
                            MaterialButton(
                              splashColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 35.0),
                              height: 30.0,
                              elevation: 5.0,
                              shape: StadiumBorder(),
                              onPressed: () {
                                if (result["streetview"] == "") {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Street View not available for this monument',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            StreetView(
                                          url: result["streetview"],
                                        ),
                                      ));
                                }
                              },
                              color: Colors.black,
                              child: Text(
                                "Open Street View",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),

                            //drive using google maps
                            MaterialButton(
                              splashColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 35.0),
                              height: 30.0,
                              elevation: 5.0,
                              shape: StadiumBorder(),
                              onPressed: () {
                                MapUtils.openMap(
                                    result["latitude"], result["longitude"]);
                              },
                              color: Colors.black,
                              child: Text(
                                "Drive there using Google-Maps",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Information",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'LexendDeca',
                                    fontSize: 20.0,
                                  ),
                                ),
                                IconButton(
                                  icon: icon,
                                  onPressed: () {
                                    text = result['info'];
                                    speak(text);
                                  },
                                )
                              ],
                            ),
                            Divider(
                              height: 20.0,
                              endIndent: 40.0,
                              indent: 40.0,
                              color: Colors.black,
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Container(
                                child: Text(
                                  result["info"].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'LexendDeca',
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      height: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      shape: StadiumBorder(),
                      child: Text(
                        "Back",
                        style: TextStyle(
                            fontFamily: 'LexendDeca',
                            fontSize: 16.0,
                            color: Theme.of(context).cardColor),
                      ),
                      color: Theme.of(context).highlightColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
