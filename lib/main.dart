

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_iiit/app/landing_page.dart';
import 'package:my_iiit/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_iiit/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../services/auth.dart';
import '/firebase_options.dart';
import 'notificationservice/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
  runApp(MyApp());

}
class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();
  final _navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IIIT SONEPAT',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
