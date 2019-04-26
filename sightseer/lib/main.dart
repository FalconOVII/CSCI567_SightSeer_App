import 'package:flutter/material.dart';
import 'package:sightseer/homepage.dart';
import 'package:sightseer/chatpage.dart';
import 'package:sightseer/Setup/signin.dart';
//import 'package:firebase_integration/Setup/signin.dart'

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sightseer',
      home: PageView(
        children: <Widget>[
          LoginPage(),
          HomePage(),
          ChatPage()
        ],
      ),
    );
  }
}