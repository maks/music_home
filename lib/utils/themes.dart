import 'package:flutter/material.dart';

enum CurrentTheme { dark, light }

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    buttonColor: Colors.white,
    unselectedWidgetColor: Colors.white,
    primaryTextTheme: TextTheme(caption: TextStyle(color: Colors.white)));

final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    backgroundColor: Colors.white,
    buttonColor: Colors.black,
    unselectedWidgetColor: Colors.white,
    primaryTextTheme: TextTheme(caption: TextStyle(color: Colors.white)));
