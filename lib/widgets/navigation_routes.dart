import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../data/music_data.dart';
import '../pages/album_tracklist.dart';
import '../pages/now_playing.dart';

mixin NavigatationRoutes on StatelessWidget {
  //Goto Now Playing Page
  void goToNowPlaying(BuildContext context, MusicData musicData, Track s,
      {bool nowPlayTap: false}) {
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

  void gotoAlbumTrackList(
      BuildContext context, MusicData musicData, Album album) {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => AlbumTrackList(data: musicData, album: album),
      ),
    );
  }
}
