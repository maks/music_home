import 'dart:io';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

Widget blurWidget(Song song) {
  final f =
      song.albumArt == null ? null : File.fromUri(Uri.parse(song.albumArt));
  return Hero(
    tag: song.artist,
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
