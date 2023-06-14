import 'package:flutter/material.dart';
import 'package:my_iiit/app/sign_in/email_sign_in_form.dart';
import 'package:my_iiit/services/auth.dart';
import 'package:my_iiit/utils/color_utils.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({@required this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("ffb84d"),
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body:
      SingleChildScrollView(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: hexStringToColor("ffe0b3"),
                child: EmailSignInForm(auth: auth),
              ),
            ),
            Text("For Trial Version"),
            Text("UID: 0@iiit.in"),
            Text("Password: 123456"),
          ],
        ),

      ),
      backgroundColor: hexStringToColor("ffe0b3"),
    );
  }
}
