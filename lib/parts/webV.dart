import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_iiit/parts/noto.dart';
import 'package:my_iiit/utils/color_utils.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  @override
  WebViewPageState createState() =>
      WebViewPageState(this.url, this.title);
}

class WebViewPageState extends State<WebViewPage> {
  String url;
  final String title;
  bool isLoading=true;
  WebViewPageState(this.url, this.title);
   WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _goBack(context),
        child: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => super.widget));

                      },

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,18,0,0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              size: 26.0,
                            ),

                          ],
                        ),
                      ),

                    )
                ),
              ],
              backgroundColor: hexStringToColor("ffb84d"),
              title: Text(this.title),
              leading: IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                  //return Navigator.of(context).pop();
                },
              ),

            ),
            body: Stack(
              children: <Widget>[
                WebView(
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.endsWith('.pdf') )
                      {
                        Navigator.pop(context);
                        _handleURLButtonPress(
                            context,"https://docs.google.com/gview?embedded=true&url="+request.url, title.toUpperCase());
                        //return NavigationDecision.navigate;
                      }
                      //return NavigationDecision.navigate;
                    },
                    initialUrl: this.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {

                      _controllerCompleter.future.then((value) => _controller = value);
                      _controllerCompleter.complete(webViewController);
                    }
                ),
                isLoading ? Center( child: CircularProgressIndicator(color: hexStringToColor("ffb84d")),)
                    : Stack(),
              ],
            )
        ),
      );

  }
  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to exit?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                  return Navigator.of(context).pop();
                },
                child: Text('YES'),
              ),
                ],
          ),
      );
      return Future.value(true);
    }
  }
}void _handleURLButtonPress(BuildContext context, String url, String title) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
}