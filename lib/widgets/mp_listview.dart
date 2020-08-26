import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_home/pages/album_tracklist.dart';
import 'package:music_home/widgets/song_list_tile.dart';

import '../data/song_data.dart';
import '../my_app.dart';
import '../pages/now_playing.dart';

class MPListView extends StatelessWidget {
  final MusicData data;
  final bool albums;
  final List<Track> tracks;

  MPListView(this.data, this.albums, {this.tracks});

  @override
  Widget build(BuildContext context) {
    final List<MusicItem> items =
        tracks != null ? tracks : (albums ? data.albums : data.songs);
    return ListView.builder(
      itemCount: items?.length ?? 0,
      itemBuilder: (context, int index) {
        final MusicItem item = items[index];

        final File artFile = (item.albumArt == null)
            ? null
            : File.fromUri(Uri.parse(item.albumArt));

        return SongListTile(
          artFile: artFile,
          title: item.title,
          artist: item.artist,
          color: MyApp.randomPrimaryColor(index),
          onSelected: () {
            data.setCurrentIndex(index);
            if (albums) {
              final Album album = item as Album;
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AlbumTrackList(data: data, album: album),
                ),
              );
            } else {
              final Track track = item as Track;
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => NowPlaying(data, track),
                ),
              );
            }
          },
        );
      },
    );
  }
}