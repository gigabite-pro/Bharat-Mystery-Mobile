import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Directions extends StatefulWidget {
  final double elong;
  final double elat;
  Directions({this.elat, this.elong});

  @override
  _DirectionsState createState() => _DirectionsState();
}

class _DirectionsState extends State<Directions> {
  Future getCurrentPos() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    slong = position.longitude;
    slat = position.latitude;
    return [slong, slat];
  }

  var slong;
  var slat;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: getCurrentPos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                backgroundColor: Theme.of(context).focusColor,
                body: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black)),
                ),
              );
            }

            final result = snapshot.data;

            return Scaffold(
              body: WebView(
                initialUrl:
                    "https://bharat-mystery-api.herokuapp.com/map?elong=${widget.elong}&elat=${widget.elat}&slong=${result[0]}&slat=${result[1]}",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            );
          }),
    );
  }
}
