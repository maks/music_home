import 'dart:async';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

import '../data/music_data.dart';
import '../widgets/mp_album_ui.dart';
import '../widgets/mp_blur_filter.dart';
import '../widgets/mp_blur_widget.dart';
import '../widgets/mp_control_button.dart';

enum PlayerState { stopped, playing, paused }

class NowPlaying extends StatefulWidget {
  final Track _song;
  final MusicData songData;
  final bool nowPlayTap;
  NowPlaying(this.songData, this._song, {this.nowPlayTap});

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  MusicFinder audioPlayer;
  Duration duration;
  Duration position;
  PlayerState playerState;
  Track song;

  bool get isPlaying => playerState == PlayerState.playing;
  bool get isPaused => playerState == PlayerState.paused;

  String get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  String get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;
  bool smallScreen = false;

  @override
  initState() {
    super.initState();
    initPlayer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    smallScreen = MediaQuery.of(context).size.height <= 480;
  }

  @override
  void dispose() {
    super.dispose();
    _clearHandlers();
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
    play(widget.songData.nextSong);
  }

  void initPlayer() async {
    if (audioPlayer == null) {
      audioPlayer = widget.songData.audioPlayer;
    }
    setState(() {
      song = widget._song;
      if (widget.nowPlayTap == null || widget.nowPlayTap == false) {
        if (playerState != PlayerState.stopped) {
          stop();
        }
      }
      play(song);
    });

    audioPlayer.setDurationHandler((d) => setState(() {
          duration = d;
        }));

    audioPlayer.setPositionHandler((p) => setState(() {
          position = p;
        }));

    audioPlayer.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;
      });
    });

    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

  Future play(Track s) async {
    if (s != null) {
      final int result = await audioPlayer.play(s.uri, isLocal: true) as int;
      if (result == 1) {
        setState(() {
          playerState = PlayerState.playing;
          song = s;
        });
      }
    }
  }

  Future pause() async {
    final int result = await audioPlayer.pause() as int;
    if (result == 1) {
      setState(() => playerState = PlayerState.paused);
    }
  }

  Future stop() async {
    final int result = await audioPlayer.stop() as int;
    if (result == 1) {
      setState(() {
        playerState = PlayerState.stopped;
        position = Duration();
      });
    }
  }

  Future next(MusicData s) async {
    stop();
    setState(() {
      play(s.nextSong);
    });
  }

  Future prev(MusicData s) async {
    stop();
    play(s.prevSong);
  }

  Future mute(bool muted) async {
    final int result = await audioPlayer.mute(muted) as int;
    if (result == 1) {
      setState(() {
        isMuted = muted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenSizeOffset = smallScreen ? 2 : 20;

    Widget _buildPlayer() => Container(
        padding: EdgeInsets.all(screenSizeOffset * 3),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(
            children: <Widget>[
              Text(
                song.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                song.artist,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 1),
              )
            ],
          ),
          Row(mainAxisSize: MainAxisSize.min, children: [
            ControlButton(Icons.skip_previous, () => prev(widget.songData)),
            ControlButton(isPlaying ? Icons.pause : Icons.play_arrow,
                isPlaying ? () => pause() : () => play(widget._song)),
            ControlButton(Icons.skip_next, () => next(widget.songData)),
          ]),
          duration == null
              ? Container()
              : Slider(
                  value: position?.inMilliseconds?.toDouble() ?? 0,
                  onChanged: (double value) =>
                      audioPlayer.seek((value / 1000).roundToDouble()),
                  min: 0.0,
                  max: duration.inMilliseconds.toDouble()),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
                position != null
                    ? "${positionText ?? ''} / ${durationText ?? ''}"
                    : duration != null ? durationText : '',
                // ignore: conflicting_dart_import
                style: Theme.of(context).textTheme.caption)
          ]),
          Padding(
            padding: EdgeInsets.only(bottom: screenSizeOffset),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: isMuted
                      ? Icon(
                          Icons.headset,
                          color: Theme.of(context).unselectedWidgetColor,
                        )
                      : Icon(Icons.headset_off,
                          color: Theme.of(context).unselectedWidgetColor),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    mute(!isMuted);
                  }),
            ],
          ),
        ]));

    final playerUI = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AlbumUI(song, duration, position),
          Material(
            child: _buildPlayer(),
            color: Colors.transparent,
          ),
        ]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[blurWidget(song), blurFilter(), playerUI],
        ),
      ),
    );
  }

  void _clearHandlers() {
    audioPlayer.setDurationHandler(null);
    audioPlayer.setPositionHandler(null);
    audioPlayer.setStartHandler(null);
    audioPlayer.setCompletionHandler(null);
    audioPlayer.setErrorHandler(null);
  }
}
