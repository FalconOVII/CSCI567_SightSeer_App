import 'package:flutter/material.dart';
import 'package:sightseer/homepage.dart';
import 'package:sightseer/chatpage.dart';
import 'package:sightseer/secondmain.dart'
    '';
//import 'package:firebase_integration/Setup/signin.dart'

class SecondMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sightseer',
      home: PageView(
        children: <Widget>[
          HomePage(),
          ChatPage(),
          WebMapPage()
        ],
      ),
    );
  }
}