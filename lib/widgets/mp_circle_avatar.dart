import 'dart:io';
import 'package:flutter/material.dart';

Widget avatar(File f, String title, MaterialColor color) {
  return Material(
    borderRadius: BorderRadius.circular(20.0),
    elevation: 3.0,
    child: f != null
        ? Image.file(
            f,
            fit: BoxFit.cover,
          )
        : CircleAvatar(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            backgroundColor: color,
          ),
  );
}
