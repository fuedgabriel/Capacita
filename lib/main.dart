import 'package:Capacita/screen/Account/Login.dart';
import 'package:flutter/material.dart';
import 'screen/Widget/BottonBar.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Imperium',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => Login(),
        '/BottonBar': (BuildContext context) => BottonBar(),

      },
    );
  }
}
