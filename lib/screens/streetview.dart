import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StreetView extends StatefulWidget {
  final String url;
  StreetView({this.url});

  @override
  _StreetViewState createState() => _StreetViewState();
}

class _StreetViewState extends State<StreetView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).highlightColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Street View",
            style: TextStyle(
                fontFamily: 'LexendDeca',
                color: Theme.of(context).highlightColor),
          ),
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
