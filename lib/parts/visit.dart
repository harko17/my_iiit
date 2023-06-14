import 'package:flutter/material.dart';
import 'package:my_iiit/utils/color_utils.dart';

class Harko extends StatelessWidget {
  const Harko({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 65,
        title: Center(child: const Text('HARKO PRIVATE LIMITED',style: TextStyle(fontSize: 25),)),
        backgroundColor: hexStringToColor("ffb84d"),
      ),
      body: Container

        (child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: FlatButton(

          onPressed: () {

          },
          child: Image.asset('assets/hk.png'),
        ),
      ),
      ),
    );
  }
}
