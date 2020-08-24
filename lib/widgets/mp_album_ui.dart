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
    return new AlbumUIState();
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
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.elasticOut);
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
    // Song song = MPInheritedWidget.of(context).songData.nextSong;
    var f = widget.song.albumArt == null
        ? null
        : new File.fromUri(Uri.parse(widget.song.albumArt));

    var myHero = new Hero(
      tag: widget.song.title,
      child: new Material(
          borderRadius: new BorderRadius.circular(5.0),
          elevation: 5.0,
          child: f != null
              ? new Image.file(
                  f,
                  fit: BoxFit.cover,
                  height: 250.0,
                  gaplessPlayback: true,
                )
              : new Image.asset(
                  "assets/music_record.jpeg",
                  fit: BoxFit.cover,
                  height: 250.0,
                  gaplessPlayback: false,
                )),
    );

    return new SizedBox.fromSize(
      size: new Size(animation.value * 250.0, animation.value * 250.0),
      child: new Stack(
        children: <Widget>[
          myHero,
        ],
      ),
    );
  }
}
