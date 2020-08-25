import 'dart:io';
import 'package:flutter/material.dart';
import 'package:music_home/data/song_data.dart';

Widget blurWidget(Track track) {
  final f =
      track.albumArt == null ? null : File.fromUri(Uri.parse(track.albumArt));
  return Hero(
    tag: track.artist,
    child: Container(
      child: f != null
          // ignore: conflicting_dart_import
          ? Image.file(
              f,
              fit: BoxFit.cover,
              color: Colors.black54,
              colorBlendMode: BlendMode.darken,
            )
          : Image(
              image: AssetImage('assets/music_record.jpeg'),
              color: Colors.black54,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
            ),
    ),
  );
}
