import 'package:avatars/avatars.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:my_iiit/utils/color_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../common_widgets/platform_alert_dialog.dart';


String gname;
String groll=null;
class users extends StatefulWidget {
  const users({key}) : super(key: key);

  @override
  _usersState createState() => _usersState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
class _usersState extends State<users> {
  ScrollController _controller = ScrollController();
  TextEditingController dateCtl = TextEditingController();

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
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
        title: Text('Profile'),
        backgroundColor: hexStringToColor("ffb84d"),
      ),
      body: body (),
      backgroundColor: hexStringToColor("ffe0b3"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {


          {
            var val1;
            var val2;
            var val3;
            var val4;
            var val5;
            Alert(

                context: context,
                title: "ADD/UPDATE",
                content: Column(

                  children: <Widget>[

                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),


                      ], // Only numbers can be entered
                      onChanged: (text2) {
                        val2 = "$text2";
                      },

                      decoration: InputDecoration(
                        icon: Icon(Icons.edit),
                        labelText: 'ROLL NO.',

                      ),
                    ),
                    TextFormField(
                      onChanged: (text3) {
                        val3 = "$text3";
                      },

                      decoration: InputDecoration(
                        icon: Icon(Icons.edit),
                        labelText: 'BRANCH',

                      ),
                    ),
                    TextFormField(
                      onChanged: (text4) {
                        val4 = "$text4";
                      },

                      decoration: InputDecoration(
                        icon: Icon(Icons.edit),
                        labelText: 'D.O.B.',

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
                        val2 = r;
                      }
                      if(val3==null)
                      {
                        val3 = b;
                      }
                      if(val4==null)
                      {
                        val4 = d;
                      }
                      if(val5==null)
                      {
                        val5 = p;
                      }
                      FirebaseFirestore.instance.collection("users").doc((inputData())).set({'name' : n, 'roll' : val2, 'branch': val3, 'dob': val4,'pic' : val5,'ecode' : e});

                      Navigator.pop(context);

                    },
                    child: Text(
                      "ADD/UPDATE",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]
            ).show();



          }
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.orange,
      ),
    );
  }
  Widget body()
  {
    var stream = FirebaseFirestore.instance.collection('users').doc(inputData()).snapshots();
    return StreamBuilder<DocumentSnapshot>(

      stream: stream,
      initialData: null,
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot) {
        switch (snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(color: hexStringToColor("ffb84d"),));

          default:

            if (snapshot.hasData) {
              n=snapshot.data['name'];
              r=snapshot.data['roll'];
              d=snapshot.data['dob'];
              b=snapshot.data['branch'];
              p=snapshot.data['pic'];
              e=snapshot.data['ecode'];
              gname=p;
              inputPhoto() {
                final user =  FirebaseAuth.instance.currentUser;
                user.updatePhotoURL(p);
                final String uid2 = user.photoURL.toString();
                return uid2;

              }
              FirebaseAuth.instance.currentUser.updateProfile(displayName: n,photoURL: p);
              FirebaseAuth.instance.currentUser.updatePhotoURL(p);
              FirebaseAuth.instance.currentUser.updateDisplayName(n);
              inputName() {
                final user =  FirebaseAuth.instance.currentUser;
                user.updateDisplayName(n);
                final String uid1 = user.displayName.toString();

                return uid1;

              }
              return Scaffold(
                  backgroundColor: hexStringToColor("ffe0b3"),
                  body: SafeArea(

                    child: Column(

                      children: [
                        Container(
                          decoration: BoxDecoration(

                          ),
                          child: Container(

                            width: double.infinity,
                            height: 200,
                            child: Container(

                              alignment: Alignment(0.0,2.5),
                              child: Stack(

                                children: [ //...
                                  Avatar(
                                    useCache: true,
                                    sources: [
                                      InstagramSource(snapshot.data['pic']),
                                      NetworkSource(snapshot.data['pic']),
                                    ],
                                    //name: snapshot.data['name'].toUpperCase(),
                                    elevation: 5,
                                    loader:  TextAvatar(
                                      shape: Shape.Circular,
                                      size: 160,
                                      textColor: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.normal,
                                      upperCase: true,
                                      backgroundColor: Colors.black,
                                      numberLetters: 2,

                                      text: snapshot.data['name'],
                                    ),
                                  )
                                  //...

                                ],
                              ),

                            ),
                          ),
                        ),
                        SizedBox(

                          height: 60,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          snapshot.data['name'].toUpperCase(),

                          style: TextStyle(

                              fontSize: 25.0,
                              color:Colors.black,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          snapshot.data['roll'].toUpperCase()
                          ,style: TextStyle(
                            fontSize: 18.0,
                            color:Colors.black87,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data['branch'].toUpperCase()
                          ,style: TextStyle(
                            fontSize: 18.0,
                            color:Colors.black87,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Born in "+snapshot.data['dob'].toUpperCase()
                          ,style: TextStyle(
                            fontSize: 15.0,
                            color:Colors.black87,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "IIIT SONEPAT || 2021-2025",
                          style: TextStyle(
                              fontSize: 18.0,
                              color:Colors.black45,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300
                          ),
                        ),

                      ],
                    ),
                  )
              );

              //this will load first

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