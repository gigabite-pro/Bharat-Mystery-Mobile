import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import "package:flutter_tts/flutter_tts.dart";

class Monument extends StatefulWidget {
  @override
  _MonumentState createState() => _MonumentState();
}

class _MonumentState extends State<Monument>
    with AutomaticKeepAliveClientMixin {
  final FlutterTts flutterTts = FlutterTts();
  Icon icon = Icon(Icons.volume_up, color: Colors.black);
  bool isSpeaking = false;

  speak() async {
    await flutterTts.setLanguage('hi-IN');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.9);
    await flutterTts.speak(
        "The Qutb Minar, also spelled as Qutub Minar and Qutab Minar, is a minaret and \"victory tower\" that forms part of the Qutb complex, a UNESCO World Heritage Site in the Mehrauli area of New Delhi, India. The height of Qutb Minar is 72.5 meters, making it the tallest minaret in the world built of bricks.The tower tapers, and has a 14.3 metres (47 feet) base diameter, reducing to 2.7 metres (9 feet) at the top of the peak. It contains a spiral staircase of 379 steps.");
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
    super.build(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xffA0E7E5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
                    child: Image.network('https://i.imgur.com/4s4YfDi.jpg'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Qutab Minar",
                    style: TextStyle(
                        fontFamily: 'LexendDeca',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900),
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
                            center: LatLng(28.5244754, 77.1833319),
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
                                  point: LatLng(28.5244754, 77.1833319),
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
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Information",
                        style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 20.0,
                        ),
                      ),
                      IconButton(
                        icon: icon,
                        onPressed: speak,
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
                        "The Qutb Minar, also spelled as Qutub Minar and Qutab Minar, is a minaret and \"victory tower\" that forms part of the Qutb complex, a UNESCO World Heritage Site in the Mehrauli area of New Delhi, India. The height of Qutb Minar is 72.5 meters, making it the tallest minaret in the world built of bricks.The tower tapers, and has a 14.3 metres (47 feet) base diameter, reducing to 2.7 metres (9 feet) at the top of the peak. It contains a spiral staircase of 379 steps.",
                        style: TextStyle(
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
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
