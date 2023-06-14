import 'package:avatars/avatars.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_iiit/utils/color_utils.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class allp extends StatefulWidget {
  const allp({key}) : super(key: key);

  @override
  _allpState createState() => _allpState();
}
FirebaseFirestore firestore = FirebaseFirestore.instance;
class _allpState extends State<allp> {
  ScrollController _controller = ScrollController();

  inputData() {
    final user =  FirebaseAuth.instance.currentUser;
    final String uid = user.email.toString();
    return uid;
  }
  var n=null;
  var r=null;
  var d=null;
  var b=null;
  var p=null;
  var e=null;

  Future<String> get uid1 => inputData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
              child: FloatingActionButton(

                onPressed: () {
                  {
                    var val1;
                    var val2;
                    Alert(

                        context: context,
                        title: "REMOVE USER",
                        content: Column(

                          children: <Widget>[
                            TextFormField(
                              onChanged: (text1) {
                                val1 = "$text1";
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.key),
                                labelText: 'CODE',

                              ),
                            ),

                          ],
                        ),
                        buttons: [
                          DialogButton(
                            color: hexStringToColor("ffb84d"),
                            onPressed: () {

                              FirebaseFirestore.instance.collection("users").doc(val1+"@iiit.in").delete();
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
              ),
            ),
            FloatingActionButton(
              onPressed: ()
              {

                {
                  var val1;
                  var val2;
                  var val3;
                  var val4;
                  var val;
                  var val5;
                  Alert(

                      context: context,
                      title: "ADD/UPDATE USER",
                      content: Column(

                        children: <Widget>[
                          TextFormField(
                            onChanged: (text) {
                              val = "$text";
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.article),
                              labelText: 'EMAIL',

                            ),
                          ),
                          TextFormField(

                            onChanged: (text1) {
                              val1 = "$text1";
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.article),
                              labelText: 'NAME',


                            ),
                          ),
                          TextFormField(
                            onChanged: (text2) {
                              val2 = "$text2";
                            },

                            decoration: InputDecoration(
                              icon: Icon(Icons.link),
                              labelText: 'ROLL NO.',

                            ),
                          ),
                          TextFormField(
                            onChanged: (text3) {
                              val3 = "$text3";
                            },

                            decoration: InputDecoration(
                              icon: Icon(Icons.link),
                              labelText: 'BRANCH',

                            ),
                          ),
                          TextFormField(
                            onChanged: (text4) {
                              val4 = "$text4";
                            },

                            decoration: InputDecoration(
                              icon: Icon(Icons.link),
                              labelText: 'D.O.B.',

                            ),
                          ),
                          TextFormField(
                            onChanged: (text5) {
                              val5 = "$text5";
                            },

                            decoration: InputDecoration(
                              icon: Icon(Icons.account_circle_outlined),
                              labelText: 'DP LINK',

                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          color: hexStringToColor("ffb84d"),
                          onPressed: () {
                            if(val1==null)
                            {
                                val1 = 'Not Added';
                              }
                            if(val2==null)
                            {
                              val2 = 'Roll No.';

                            }
                            if(val3==null)
                            {
                              val3 = 'Branch';

                            }
                            if(val4==null)
                            {
                              val4 = 'Date of Birth';

                            }
                            if(val5==null)
                            {
                              val5 = 'https://drive.google.com/uc?export=view&id=1gumU8o7WAHxu_jczf1kVTh35R0_JgC7L';

                            }
                            FirebaseFirestore.instance.collection("users").doc(val+"@iiit.in").set({'ecode' : val,'name' : (val1), 'roll' : val2, 'branch': val3, 'dob': val4,'pic' : val5});

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
            ),
          ],
        ),
      ),
    );
  }
  Widget body()
  {
    var stream = FirebaseFirestore.instance.collection('users').snapshots();
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
                    String name = snapshot.data.docs.elementAt(index).get("name");
                    String roll = snapshot.data.docs.elementAt(index).get("roll");
                    String branch = snapshot.data.docs.elementAt(index).get("branch");
                    String dob = snapshot.data.docs.elementAt(index).get("dob");
                    String ecode = snapshot.data.docs.elementAt(index).get("ecode");
                    String pic = snapshot.data.docs.elementAt(index).get("pic");


                    n=name;
                    r=roll;
                    b=branch;
                    d=dob;
                    e=ecode;

                    return ListTile(
                      selectedColor: Colors.orangeAccent,

                      title: Text(ecode+" "+name+"  "+branch, style: TextStyle(fontSize: 20.0),),
                      subtitle: Text(roll+"  "+dob, style: TextStyle(fontSize: 15.0),),
                      leading: CircleAvatar(
                        radius: 30,
                        child: Avatar(
                          useCache: true,
                          sources: [
                            InstagramSource(pic),
                          ],
                          //name: snapshot.data['name'].toUpperCase(),
                          elevation: 5,
                          loader:  TextAvatar(
                            shape: Shape.Circular,
                            size: 100,
                            textColor: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            upperCase: true,
                            backgroundColor: Colors.black,
                            numberLetters: 2,

                            text: name,
                          ),
                        ),
                      )
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
