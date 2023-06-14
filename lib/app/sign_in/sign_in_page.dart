import 'package:flutter/material.dart';
import 'package:my_iiit/app/sign_in/email_sign_in_page.dart';
import 'package:my_iiit/app/sign_in/sign_in_button.dart';
import 'package:my_iiit/app/sign_in/social_sign_in_button.dart';
import 'package:my_iiit/parts/new_sign.dart';
import 'package:my_iiit/services/auth.dart';
import 'package:my_iiit/reusable_widgets/reusable_widget.dart';

import 'package:my_iiit/utils/color_utils.dart';


class SignInPage extends StatefulWidget {
  SignInPage({@required this.auth});

  final AuthBase auth;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    onLongPress: (){

                    },
                    child: Text('IIIT SONEPAT',
                      style: TextStyle(color: hexStringToColor("014c97"), fontSize: 30,),
                    ),
                  ),
                ),
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
}

