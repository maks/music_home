import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

import 'mp_inherited.dart';

class MPDrawer extends StatefulWidget {
  @override
  MPDrawerState createState() {
    return MPDrawerState();
  }
}

class MPDrawerState extends State<MPDrawer> {
  bool dark;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context).songData;
    final cI = rootIW.currentIndex;
    final Song song =
        rootIW.songs[((cI == null) || (cI < 0)) ? 0 : rootIW.currentIndex];
    final f =
        song.albumArt == null ? null : File.fromUri(Uri.parse(song.albumArt));
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.zero,
          child: f != null
              ? Image.file(
                  f,
                  fit: BoxFit.fill,
                  gaplessPlayback: true,
                )
              : Image.asset(
                  'assets/music_record.jpeg',
                  fit: BoxFit.fill,
                  scale: 5.0,
                  gaplessPlayback: true,
                ),
        ),
      ],
    ));
  }
}
