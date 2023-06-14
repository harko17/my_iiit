
import 'package:avatars/avatars.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_iiit/utils/color_utils.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

inputData() {
  final user =  FirebaseAuth.instance.currentUser;
  final String uid = user.email.toString();
  return uid;
}
class faculty extends StatefulWidget {
  const faculty({key}) : super(key: key);

  @override
  _facultyState createState() => _facultyState();
}
FirebaseFirestore firestore = FirebaseFirestore.instance;
class _facultyState extends State<faculty> {
  ScrollController _controller = ScrollController();

  inputData() {
    final user =  FirebaseAuth.instance.currentUser;
    final String uid = user.email.toString();
    return uid;
  }
  var n=null;
  var s=null;
  var c=null;
  var p=null;

  Future<String> get uid1 => inputData();

  @override
  Widget build(BuildContext context) {
    Widget add() {
      if (inputData()!='5@iiit.in') {
        return Container();
      } else {
        return FloatingActionButton(
          onPressed: ()
          {

            {
              var val1;
              var val2;
              var val3;
              var val;
              Alert(

                  context: context,
                  title: "ADD/UPDATE FACULTY",
                  content: Column(

                    children: <Widget>[
                      TextFormField(
                        onChanged: (text) {
                          val = "$text";
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.key),
                          labelText: 'CODE',

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
                        onChanged: (text3) {
                          val2 = "$text3";
                        },

                        decoration: InputDecoration(
                          icon: Icon(Icons.link),
                          labelText: 'SUBJECT',

                        ),
                      ),

                      TextFormField(
                        onChanged: (text5) {
                          val3 = "$text5";
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
                          val1 = 'Name';
                        }
                        if(val2==null)
                        {
                          val2 = 'Subject';

                        }

                        if(val3==null)
                        {
                          val3 = 'https://drive.google.com/uc?export=view&id=1gumU8o7WAHxu_jczf1kVTh35R0_JgC7L';

                        }
                        FirebaseFirestore.instance.collection("Faculty").doc(val).set({'code' : val,'name' : (val1), 'sub':val2,'pic' : val3});

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
                  title: "REMOVE FACULTY",
                  content: Column(

                    children: <Widget>[
                      TextFormField(
                        onChanged: (text1) {
                          val1 = "$text1";
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.article),
                          labelText: 'CODE',

                        ),
                      ),

                    ],
                  ),
                  buttons: [
                    DialogButton(
                      color: hexStringToColor("ffb84d"),
                      onPressed: () {

                        FirebaseFirestore.instance.collection("Faculty").doc(val1).delete();
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
        title: Text('Faculty'),
        backgroundColor: hexStringToColor("ffb84d"),
      ),
      body: body (),
      backgroundColor: hexStringToColor("ffe0b3"),

      floatingActionButton:

      Padding(
        padding: const EdgeInsets.only(top: 600),

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: delete()
            ),
            add()
          ],
        ),
      ),
    );
  }
  Widget body()
  {
    var stream = FirebaseFirestore.instance.collection('Faculty').snapshots();
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
                    String sub = snapshot.data.docs.elementAt(index).get("sub");

                    String code = snapshot.data.docs.elementAt(index).get("code");
                    String pic = snapshot.data.docs.elementAt(index).get("pic");


                    n=name;
                    s=sub;

                    c=code;

                    return ListTile(
                        selectedColor: Colors.orangeAccent,

                        title: Text(code+" "+name+"  ", style: TextStyle(fontSize: 25.0),),
                        subtitle: Text("Subject : "+sub, style: TextStyle(fontSize: 20.0),),
                        leading:
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(pic),

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

