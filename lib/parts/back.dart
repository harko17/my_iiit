
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_iiit/parts/back2.dart';
import 'package:my_iiit/utils/color_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../common_widgets/platform_alert_dialog.dart';
String caller="";
String caller2="";
String caller3="";

inputData() {
  final user =  FirebaseAuth.instance.currentUser;
  final String uid = user.email.toString();
  return uid;
}
class back extends StatefulWidget {
  const back({key}) : super(key: key);

  @override
  _backState createState() => _backState();
}
FirebaseFirestore firestore = FirebaseFirestore.instance;
class _backState extends State<back> {
  ScrollController _controller = ScrollController();

  Future<String> get uid1 => inputData();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    Widget add(){
      if (inputData()!='5@iiit.in') {
        return Container();
      } else {
        return FloatingActionButton(

          onPressed: ()
          {
            {
              var val1;
              var val2;
              Alert(

                  context: context,
                  title: "ADD/UPDATE "+caller2.toUpperCase(),
                  content: Column(

                    children: <Widget>[
                      TextFormField(
                        onChanged: (text1) {
                          val1 = "$text1";
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.article),
                          labelText: 'Name',

                        ),
                      ),

                    ],
                  ),
                  buttons: [
                    DialogButton(
                      color: hexStringToColor("ffb84d"),
                      onPressed: () {

                        FirebaseFirestore.instance.collection("front/$caller2/$caller2").doc((val1)).set({'title' : (val1)});

                        Navigator.pop(context);

                      },
                      child: Text(
                        "ADD/UPDATE AS ADMIN",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ]
              ).show();



            }

          },

          child: Icon(Icons.add),
          backgroundColor: Colors.orange,
        );
      }
    }
    Widget delete() {
      if (inputData() != '5@iiit.in') {
        return Container();
      } else {
        return FloatingActionButton(

          onPressed: () {
            {
              var val1;
              var val2;
              Alert(

                  context: context,
                  title: "DELETE "+caller2.toUpperCase(),
                  content: Column(

                    children: <Widget>[
                      TextFormField(
                        onChanged: (text1) {
                          val1 = "$text1";
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.article),
                          labelText: 'Full Name',

                        ),
                      ),

                    ],
                  ),
                  buttons: [
                    DialogButton(
                      color: hexStringToColor("ffb84d"),
                      onPressed: () {
                        FirebaseFirestore.instance.collection("front/$caller2/$caller2").doc(
                            (val1)).delete();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "DELETE AS ADMIN",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ]
              ).show();
            }
          },

          child: Icon(Icons.delete),
          backgroundColor: Colors.orange,
        );
      }
    }
    setState(() {
      caller2=caller;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(caller.toUpperCase()),
        backgroundColor: hexStringToColor("ffb84d"),
      ),
      body:
      body (),
      backgroundColor: hexStringToColor("ffe0b3"),

      floatingActionButton:

      Padding(
        padding: const EdgeInsets.only(top: 550),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(18.0),

                child: add()
            ),
            delete()
          ],
        ),
      ),



    );

  }

  Widget body()
  {

    var stream = FirebaseFirestore.instance.collection('front/$caller/$caller').snapshots();
    String caller1=caller;
    return  StreamBuilder(
      stream: stream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(color: hexStringToColor("ffb84d")),
          );
        }
        caller="";

        return GridView.count(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          crossAxisCount: 2,

          children: snapshot.data.docs.map((document) {
            var title=document['title'];
            return SizedBox.fromSize(
              size: Size(56, 56), // button width and height
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRect(

                  child: Material(
                    color: hexStringToColor("ffcc80"), // button color
                    child: InkWell(
                      splashColor: Colors.orange, // splash color
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          caller="$title";
                          caller3=caller1;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => back2()),
                          );
                        });
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if(caller1=="lectures")
                          Icon(Icons.airplay_outlined,color: Colors.deepOrange,), // icon
                          Text(title,style: TextStyle(color: Colors.deepOrange,fontSize: 20),), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );

          }).toList(),
        );
      },
    );
  }
  Widget center(String text) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: Text(
        '$text',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }

  Widget appBar(){

  }
}

