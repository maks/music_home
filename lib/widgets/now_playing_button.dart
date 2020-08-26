import 'package:flutter/material.dart';
import 'package:music_home/data/song_data.dart';
import 'package:music_home/pages/now_playing.dart';

import 'mp_inherited.dart';

class NowPlayingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);
    //Goto Now Playing Page
    void goToNowPlaying(Track s, {bool nowPlayTap: false}) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => NowPlaying(
            rootIW.songData,
            s,
            nowPlayTap: nowPlayTap,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: InkWell(
            child: Text('Now Playing'),
            onTap: () => goToNowPlaying(
                  rootIW.songData.currentlyPlayingTrack,
                  nowPlayTap: true,
                )),
      ),
    );
  }
}
