import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_iiit/app/sign_in/email_sign_in_page.dart';
import 'package:my_iiit/app/sign_in/sign_in_button.dart';
import 'package:my_iiit/parts/webV.dart';
import 'package:my_iiit/services/auth.dart';

import 'package:my_iiit/utils/color_utils.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

bool admin=false;
class NewSignIn extends StatefulWidget {
  NewSignIn({@required this.auth});

  final AuthBase auth;

  @override
  State<NewSignIn> createState() => _NewSignInState();
}

class _NewSignInState extends State<NewSignIn> {
  Future<void> _signInAnonymously() async {
    try {
      await widget.auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await widget.auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await widget.auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: widget.auth),
      ),
    );
  }

  final StreamController<bool> _verificationNotifier =
  StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("ffe0b3"),
              hexStringToColor("ffe0b3"),
              hexStringToColor("ffcc80")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery
                .of(context)
                .size
                .height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/lg.png",scale: 0.8),
                _defaultLockScreenButton(context),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SignInButton(

                    text: 'SIGN IN',
                    textColor: Colors.black,
                    color: Colors.white70,

                    onPressed: () => _signInWithEmail(context),

                  ),
                ),

                SizedBox(height: 8.0),

                /*SignInButton(
                  text: 'Trial Version',
                  textColor: Colors.black,
                  color: Colors.white70,
                  onPressed: _signInAnonymously,
                ),*/


              ],
            ),
          ),
        ),
      ),
    );
  }

  _defaultLockScreenButton(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextButton(
          child: Text('IIIT SONEPAT',
            style: TextStyle(color: hexStringToColor("014c97"), fontSize: 30,),
          ),
          onPressed:(){
            _handleURLButtonPress(
                context,"http://www.iiitsonepat.ac.in/", "IIIT SONEPAT");
          },
          onLongPress: () {
            _showLockScreen(
              context,
              opaque: false,
              cancelButton: Text(
                'Cancel',
                style: const TextStyle(fontSize: 16, color: Colors.white),
                semanticsLabel: 'Cancel',
              ),
            );
          },
        ),
      );


  _showLockScreen(BuildContext context, {
    @required bool opaque,
    CircleUIConfig circleUIConfig,
    KeyboardUIConfig keyboardUIConfig,
    @required Widget cancelButton,
    List<String> digits,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
                title: Text(
                  'Enter Admin Passcode',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
                circleUIConfig: circleUIConfig,
                keyboardUIConfig: keyboardUIConfig,
                passwordEnteredCallback: _onPasscodeEntered,
                cancelButton: cancelButton,
                deleteButton: Text(
                  'Delete',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  semanticsLabel: 'Delete',
                ),
                shouldTriggerVerification: _verificationNotifier.stream,
                backgroundColor: Colors.black.withOpacity(0.8),
                cancelCallback: _onPasscodeCancelled,
                digits: digits,
                passwordDigits: 6,
              ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid2 = "941561" == enteredPasscode;
    if (isValid2) {
      Navigator.pop(context);
      setState(() {
        admin=true;
        _signInWithEmail(context);
      });

    }
    if (!isValid2) {
      Navigator.pop(context);

      setState(() {
        admin=false;
        _signInWithEmail(context);
      });

    }
    _verificationNotifier.add(isValid2);
    if (isValid2)
    {
      setState(()
      {
        this.isAuthenticated = isValid2;
      });
    }

  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

}

