import 'dart:math';
import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:my_iiit/app/sign_in/sign_in_page.dart';
import 'package:my_iiit/parts/back2.dart';
import 'package:my_iiit/parts/back.dart';
import 'package:my_iiit/parts/noto.dart';
import 'package:my_iiit/parts/webV.dart';
import 'package:my_iiit/services/auth.dart';
import 'package:my_iiit/reusable_widgets/reusable_widget.dart';
import 'package:my_iiit/utils/color_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widgets/platform_alert_dialog.dart';
import 'package:my_iiit/parts/myp.dart';
import 'package:my_iiit/parts/allp.dart';
import '../parts/faculty.dart';
import 'package:package_info_plus/package_info_plus.dart';

inputData() {
  final user =  FirebaseAuth.instance.currentUser;
  final String uid = user.email.toString();
  return uid;
}

_launchURL() async {
  var url = "https://sites.google.com/view/harkodev/home";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class HomePage extends StatefulWidget {
  HomePage({@required this.auth});
  final AuthBase auth;

  @override
  State<HomePage> createState() => _HomePageState();
}
FirebaseFirestore firestore = FirebaseFirestore.instance;

class _HomePageState extends State<HomePage> {

  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }
  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(

      title: 'Logout',
      content: 'Are you sure you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Confirm',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut();
    }
  }


  inputP() {
    final user =  FirebaseAuth.instance.currentUser;
    final String uid2 = user.photoURL.toString();
    return uid2;

  }
  inputN() {
    final user =  FirebaseAuth.instance.currentUser;
    final String uid1 = user.displayName.toString();

    return uid1;

  }
  var n=null;

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(

        toolbarHeight: 65.0,

        actions: <Widget>[

          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _confirmSignOut(context);
                },

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,14,0,2),
                  child: Column(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 26.0,
                      ),
                      Text("Sign out"),
                    ],
                  ),
                ),

              )
          ),


        ],
        title: Text('IIIT SONEPAT' ,style: TextStyle(fontSize: 23.0)),
        centerTitle: true,
        backgroundColor: hexStringToColor("ffb84d"),

      ),

      floatingActionButton: Stack(
        children: <Widget>[


          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: hexStringToColor("ff9900"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => noto()),
                );
              },
              child: Icon(Icons.add_alert_rounded),
            ),
          ),
        ],
      ),

      drawer: Drawer(

        backgroundColor: hexStringToColor("ffe0b3"),

        child: ListView(

          children: <Widget>[
            D(),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('My Profile'),
              onTap: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => users()),
                );
              },

            ),

            if(inputData()=='5@iiit.in')
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text('All Profile'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => allp()),
                  );
                },

              ),

            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Faculty'),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => faculty()),
                );
              },
            ),
            //P(),
            P1(),
            ListTile(

              leading: Icon(Icons.add_ic_call),
              title: Text('Contacts'),
              onTap: (){
                _handleURLButtonPress(
                    context,"http://www.iiitsonepat.ac.in/contact-us", "IIIT SONEPAT");
              },
            ),
            ListTile(
              leading: Icon(Icons.add_location),
              title: Text('Location'),
              onTap: (){
                if (canLaunch("https://www.google.com/maps/place/IIT+Delhi+Sonipat+Campus/@28.952134,77.1015126,16.74z/data=!4m12!1m6!3m5!1s0x390daddf6cade053:0xfd7ceeb61e0dbbe1!2sIIT+Delhi+Sonipat+Campus!8m2!3d28.952104!4d77.1039313!3m4!1s0x390daddf6cade053:0xfd7ceeb61e0dbbe1!8m2!3d28.952104!4d77.1039313") != null)
                {
                  _handleURLButtonPress(
                      context,"https://www.google.com/maps/place/IIT+Delhi+Sonipat+Campus/@28.952134,77.1015126,16.74z/data=!4m12!1m6!3m5!1s0x390daddf6cade053:0xfd7ceeb61e0dbbe1!2sIIT+Delhi+Sonipat+Campus!8m2!3d28.952104!4d77.1039313!3m4!1s0x390daddf6cade053:0xfd7ceeb61e0dbbe1!8m2!3d28.952104!4d77.1039313", "IIIT SONEPAT");
                } else {
                  launch("http://www.iiitsonepat.ac.in/contact-us");
                }


              },

            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('About'),
              onTap: (){
                _handleURLButtonPress(
                    context,"http://www.iiitsonepat.ac.in/", "IIIT SONEPAT");
              },
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: V(),
              onTap: null

            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: (){
                _confirmSignOut(context);
              },

            ),
            Container(
              alignment: Alignment.bottomCenter,
              color: hexStringToColor("ffe0b3"),

              child: GestureDetector(child: Image.asset('assets/hk.png',scale: 5,),
                onTap: _launchURL,
              ),
            ),
          ],
        ),

      ),

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
              hexStringToColor("ffcc80"),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: ImageSlideshow(

                  /// Width of the [ImageSlideshow].
                  width: double.infinity,


                  /// Height of the [ImageSlideshow].


                  /// The page to show when first creating the [ImageSlideshow].
                  initialPage: 0,

                  /// The color to paint the indicator.
                  indicatorColor: Colors.red,

                  /// The color to paint behind th indicator.
                  indicatorBackgroundColor: Colors.grey,

                  /// The widgets to display in the [ImageSlideshow].
                  /// Add the sample image file into the images folder
                  children: [
                    Image.asset(
                      'assets/a.jpg',
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      'assets/b.jpg',
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      'assets/c.jpg',
                      fit: BoxFit.contain,
                    ),

                    Image.asset(
                      'assets/e.jpg',
                      fit: BoxFit.contain,
                    ),
                  ],

                  /// Called whenever the page in the center of the viewport changes.


                  /// Auto scroll interval.
                  /// Do not auto scroll with null or 0.
                  autoPlayInterval: 3000,

                  /// Loops back to first slide.
                  isLoop: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Image.asset("assets/lg.png"),
                    Text('IIIT SONEPAT',
                      style: TextStyle(color: hexStringToColor("014c97"), fontSize: 25),
                    ),
                    Text('Student Portal',
                      style: TextStyle(color: hexStringToColor("014c97"), fontSize: 18),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: front(),
                    ),
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  Widget front()
  {
    var stream = FirebaseFirestore.instance.collection('front').snapshots();
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

        return SingleChildScrollView(
          child: Column(
            children: [
              GridView.count(
                childAspectRatio: (30/15),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisCount: 2,

                children: snapshot.data.docs.map((document) {
                  var title=document['title'];
                  return SizedBox.fromSize(
                    size: Size(56,25), // button width and height
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Material(
                        color: hexStringToColor("ffb84d"), // button color
                        child: InkWell(

                          splashColor: Colors.orange, // splash color
                          onTap: () {

                            setState(() {
                              caller="$title";
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => back()),
                              );
                            });
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(title.toUpperCase(),style: TextStyle(color: Colors.deepOrange,fontSize: 20),), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget P1()
  {

    var stream = FirebaseFirestore.instance.collection('drawer').snapshots();
    return  StreamBuilder(
      stream: stream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(color: hexStringToColor("ffb84d")),
          );
        }

        return ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),

          children: snapshot.data.docs.map((document) {
            var title=document['title'];
            var link=document['link'];
            int icon=document['icon'];
            return ListTile(
              leading: Icon(IconData(icon, fontFamily: 'MaterialIcons')),
              title: Text(title),
              onTap: (){
                _handleURLButtonPress(
                    context,"$link", "$title");
              },
            );

          }).toList(),
        );
      },
    );
  }

  Widget P()
  {
    var stream = FirebaseFirestore.instance.collection('drawer').doc("Placements").snapshots();
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
              String link=snapshot.data['link'];
              String title=snapshot.data['title'];
              return ListTile(

                leading: Icon(Icons.analytics_outlined),
                title: Text(title),
                onTap: (){
                  _handleURLButtonPress(
                      context,"$link", "$title");
                },
              );

              //this will load first

            }
            else
            {
              return Center(child: Text("Getting Error"));
            }

        }
      },
    );
  }
}
Widget D()
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


            return Card(

              color: hexStringToColor("ffb84d"),
              elevation: 5,
              child: DrawerHeader
                (

                decoration: BoxDecoration(
                  color: hexStringToColor("ffb84d"),


                ),

                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: CircleAvatar(
                          radius: 30,
                          child: Avatar(

                            useCache: true,
                            sources: [
                              InstagramSource(snapshot.data['pic']),
                              NetworkSource(snapshot.data['pic']),

                            ],
                            //name: snapshot.data['name'].toUpperCase(),
                            elevation: 5,
                            loader:  TextAvatar(
                              shape: Shape.Circular,
                              size: 30,
                              textColor: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              upperCase: true,
                              backgroundColor: Colors.black,
                              numberLetters: 2,

                              text: snapshot.data['name'],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(snapshot.data['name'].toUpperCase(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(snapshot.data['branch'].toUpperCase(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(inputData(),
                        style: TextStyle(fontSize: 15,color: Colors.black54),
                      ),
                    ),

                  ],
                ),

              ),
            );

            //this will load first

          }
          else
          {
            return Center(child: Text("Getting Error"));
          }

      }
    },
  );
}
Widget V()
{
  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }
  return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return FutureBuilder<PackageInfo>(
          future: _getPackageInfo(),
          builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
            if (snapshot.hasError) {
              return const Text('ERROR');
            } else if (!snapshot.hasData) {
              return const Text('Loading...');
            }

            final data = snapshot.data;
            return Align(
              alignment: Alignment.centerLeft,
              child: Text('Version: ${data.version}+${data.buildNumber}'),
            );
          },
        );
      }
  );
}

