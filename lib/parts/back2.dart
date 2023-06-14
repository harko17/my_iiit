import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_iiit/parts/back.dart';
import 'package:my_iiit/parts/webV.dart';
import 'package:my_iiit/utils/color_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../common_widgets/platform_alert_dialog.dart';

inputData() {
  final user =  FirebaseAuth.instance.currentUser;
  final String uid = user.email.toString();
  return uid;
}
class back2 extends StatefulWidget {
  const back2({key}) : super(key: key);

  @override
  _back2State createState() => _back2State();
}
FirebaseFirestore firestore = FirebaseFirestore.instance;
class _back2State extends State<back2> {
  ScrollController _controller = ScrollController();
  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }
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
                  title: "ADD/UPDATE IN "+caller2.toUpperCase(),
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
                      TextFormField(
                        onChanged: (text2) {
                          val2 = "$text2";
                        },

                        decoration: InputDecoration(
                          icon: Icon(Icons.link),
                          labelText: 'Link',

                        ),
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      color: hexStringToColor("ffb84d"),
                      onPressed: () {
                        if(val2==null)
                        {
                          val2 = 'Not Added';
                        }
                        FirebaseFirestore.instance.collection("front/$caller3/$caller3/$caller2/$caller2").doc((val1)).set({'title' : (val1), 'link' : val2});

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
                  title: "DELETE LECTURE",
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
                        FirebaseFirestore.instance.collection("front/$caller3/$caller3/$caller2/$caller2").doc(
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
    return Scaffold(
      appBar: AppBar(
        title: Text(caller),
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

    var stream = FirebaseFirestore.instance.collection('front/$caller3/$caller3/$caller/$caller').snapshots();
    return StreamBuilder(

      stream: stream,
      initialData: null,
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
        switch (snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(color: hexStringToColor("ffb84d"),));

          default:
            if(snapshot.hasData){
              if(snapshot.data.docs.length == 0)
              {
                return center('No data found');
              }
              else
              {
                return ListView.separated(
                  itemBuilder: (____, int index) {
                    Map<String,dynamic> docData = snapshot.data.docs[index].data();
                    if(docData.isEmpty)
                    {
                      return ListTile(
                        title: Text(
                          "No Data",
                          style: TextStyle(fontSize: 25.0),
                        ),
                      );
                    }
                    String title = snapshot.data.docs.elementAt(index).get("title");
                    String link= snapshot.data.docs.elementAt(index).get("link");

                    _launchURL() async {
                      var url = link;
                      if (await canLaunch(url)) {

                        await caller3!="lectures" ? _handleURLButtonPress(
                            context,"$url", title.toUpperCase()) : launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }
                    return Card(
                      color: hexStringToColor("ffcc80"),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Container(

                          child: ListTile(

                            selectedColor: Colors.orangeAccent,
                            leading: Icon(Icons.play_arrow_outlined,color: Colors.deepOrange,size: 32,),

                            title: Text(title, style: TextStyle(fontSize: 20.0),),
                            subtitle: Text('Tap to open', style: TextStyle(fontSize: 15.0),),
                            onTap: _launchURL,

                          ),

                        ),
                      ),
                    );
                  },
                  separatorBuilder: (____,___) {
                    return const Divider();
                  },
                  itemCount: snapshot.data.docs.length,
                );
              }
            }
            else
            {
              return center("Getting Error");
            }
        }
      },);
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

