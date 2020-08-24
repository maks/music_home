import 'package:flutter/material.dart';
import 'my_app.dart';
import 'utils/themes.dart';

void main() => runApp(MyMaterialApp());

class MyMaterialApp extends StatefulWidget {
  @override
  MyMaterialAppState createState() {
    return MyMaterialAppState();
  }
}

class MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, theme: darkTheme, home: MyApp());
  }
}
