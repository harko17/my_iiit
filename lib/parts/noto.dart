import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_iiit/parts/back.dart';
import 'package:my_iiit/parts/back2.dart';
import 'package:my_iiit/parts/webV.dart';


import 'package:my_iiit/utils/color_utils.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

inputData() {
  final user =  FirebaseAuth.instance.currentUser;
  final String uid = user.email.toString();
  return uid;
}
class noto extends StatefulWidget {
  const noto({key}) : super(key: key);

  @override
  _notoState createState() => _notoState();
}
FirebaseFirestore firestore = FirebaseFirestore.instance;
class _notoState extends State<noto> {
  ScrollController _controller = ScrollController();

  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }
  @override
  Widget build(BuildContext context) {
    Widget delete() {
      if (inputData()!='5@iiit.in') {
        return Container();
      } else {
        return FloatingActionButton(

          onPressed: () {
            {
              var val1;
              var val2;
              Alert(

                  context: context,
                  title: "DELETE NOTIFICATION",
                  content: Column(

                    children: <Widget>[
                      TextFormField(
                        onChanged: (text1) {
                          val1 = "$text1";
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.article),
                          labelText: 'TITLE',

                        ),
                      ),

                    ],
                  ),
                  buttons: [
                    DialogButton(
                      color: hexStringToColor("ffb84d"),
                      onPressed: () {

                        FirebaseFirestore.instance.collection("Notifications").doc((val1)).delete();
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
    Widget add() {
      if (inputData()!='5@iiit.in') {
        return Container();
      } else {
        return FloatingActionButton(
          onPressed: () {
            {
              var val1;
              var val2;
              var val3;
              Alert(

                  context: context,
                  title: "ADD Notification",
                  content: Column(

                    children: <Widget>[
                      TextFormField(
                        onChanged: (text1) {
                          val1 = "$text1";
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_alert),
                          labelText: 'Enter title',

                        ),
                      ),
                      TextFormField(
                        onChanged: (text2) {
                          val2 = "$text2";
                        },

                        decoration: InputDecoration(
                          icon: Icon(Icons.article),
                          labelText: 'Enter details',

                        ),
                      ),
                      TextFormField(
                        onChanged: (text3) {
                          val3 = "$text3";
                        },

                        decoration: InputDecoration(
                          icon: Icon(Icons.link),
                          labelText: 'Enter link',

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
                          val2 = 'Loading...';
                        }
                        if(val3==null)
                        {
                          val3 = '';
                        }
                        FirebaseFirestore.instance.collection("Notifications").doc((val1)).set({'alert' : (val1), 'ring' : val2, 'link': val3 });

                        Navigator.pop(context);

                      },
                      child: Text(
                        "ADD AS ADMIN",
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


    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 20,
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Notifications',style: TextStyle(fontSize: 22.0),),
        ),
        backgroundColor: hexStringToColor("ffb84d"),
      ),
      body: body (),
      backgroundColor: hexStringToColor("ffe0b3"),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 600),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: delete(),
            ),
            add(),
          ],
        ),
      ),
    );
  }
  Widget body()
  {
    var stream = FirebaseFirestore.instance.collection('Notifications').orderBy('ring').snapshots();
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
                    String alert = snapshot.data.docs.elementAt(index).get("alert").toUpperCase();
                    String ring= snapshot.data.docs.elementAt(index).get("ring");
                    String link= snapshot.data.docs.elementAt(index).get("link");


                    _launchURL() async {
                      var url = link;
                      if (await canLaunch(url)) {
                        await _handleURLButtonPress(
                            context,"$url", "IIIT SONEPAT");
                      } else {
                        throw 'Could not launch $url';
                      }
                    }
                    return Card(
                      child:Container(
                        height: 100,
                        color: hexStringToColor("ffcc80"),
                        child: Row(
                          children: [

                            Expanded(
                              child:Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: ListTile(
                                        leading: Icon(Icons.add_alert,color: Colors.deepOrange,size: 32,),
                                        title: Text(alert.toUpperCase(), style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
                                        subtitle: Text(ring, style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500),),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [

                                          SizedBox(width: 8,),
                                          if(link!='' && link!='alert')
                                            TextButton(
                                              child: Text("DOWNLOAD",style: TextStyle(color: Colors.black),),

                                              onPressed: ()

                                              {
                                                _launchURL();
                                              },
                                            ),
                                          if(link=='alert')
                                            TextButton(
                                              child: Text('View '+
                                                 ring.substring(0,ring.indexOf(','))
                                              ,style: TextStyle(color: Colors.black),),

                                              onPressed: ()
                                              {
                                                Navigator.pop(context);
                                                setState(() {
                                                  caller=ring.substring(0,ring.indexOf(','));
                                                  caller3="lectures";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => back2()),
                                                  );
                                                });
                                              },
                                            ),
                                          SizedBox(width: 8,)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              flex:8 ,
                            ),
                          ],
                        ),
                      ),
                      elevation: 2,
                      margin: EdgeInsets.all(10),
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
