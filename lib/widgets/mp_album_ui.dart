import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

class AlbumUI extends StatefulWidget {
  final Song song;
  final Duration position;
  final Duration duration;
  AlbumUI(this.song, this.duration, this.position);
  @override
  AlbumUIState createState() {
    return AlbumUIState();
  }
}

class AlbumUIState extends State<AlbumUI> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.song.albumArt == null
        ? null
        : File.fromUri(Uri.parse(widget.song.albumArt));

    final myHero = Hero(
      tag: widget.song.title,
      child: Material(
          borderRadius: BorderRadius.circular(5.0),
          elevation: 5.0,
          child: f != null
              ? Image.file(
                  f,
                  fit: BoxFit.cover,
                  height: 250.0,
                  gaplessPlayback: true,
                )
              : Image.asset(
                  'assets/music_record.jpeg',
                  fit: BoxFit.cover,
                  height: 250.0,
                  gaplessPlayback: false,
                )),
    );

    return SizedBox.fromSize(
      size: Size(animation.value * 250.0, animation.value * 250.0),
      child: Stack(
        children: <Widget>[
          myHero,
        ],
      ),
    );
  }
}
