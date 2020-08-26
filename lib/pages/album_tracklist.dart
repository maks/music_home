import 'package:flutter/material.dart';
import 'package:music_home/widgets/now_playing_button.dart';
import '../data/song_data.dart';
import '../widgets/mp_listview.dart';

class AlbumTrackList extends StatelessWidget {
  final Album album;
  final MusicData data;

  const AlbumTrackList({Key key, this.album, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
        actions: <Widget>[
          NowPlayingButton(),
        ],
      ),
      body: MPListView(data, false, tracks: album.tracks),
    );
  }
}
