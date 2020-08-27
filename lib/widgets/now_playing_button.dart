import 'package:flutter/material.dart';
import 'package:music_home/data/music_data.dart';
import 'package:music_home/pages/now_playing.dart';
import 'package:provider/provider.dart';

class NowPlayingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicData = Provider.of<MusicData>(context);
    //Goto Now Playing Page
    void goToNowPlaying(Track s, {bool nowPlayTap: false}) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => NowPlaying(
            musicData,
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
                  musicData.currentlyPlayingTrack,
                  nowPlayTap: true,
                )),
      ),
    );
  }
}
