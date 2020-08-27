import 'dart:io';

import 'package:flutter/material.dart';

import '../data/music_data.dart';
import '../my_app.dart';
import 'navigation_routes.dart';
import 'track_list_tile.dart';

class MPListView extends StatelessWidget with NavigatationRoutes {
  final MusicData musicData;
  final bool albums;
  final List<Track> tracks;

  bool get isAlbumTrackList => tracks != null;

  MPListView(this.musicData, this.albums, {this.tracks});

  @override
  Widget build(BuildContext context) {
    final List<MusicItem> items = tracks != null
        ? tracks
        : (albums ? musicData.albums : musicData.tracks);
    return ListView.builder(
      itemCount: items?.length ?? 0,
      itemBuilder: (context, int index) {
        final MusicItem item = items[index];

        final File artFile = (item.albumArt == null)
            ? null
            : File.fromUri(Uri.parse(item.albumArt));

        return TrackListTile(
          artFile: artFile,
          title: item.title,
          artist: item.artist,
          color: MyApp.randomPrimaryColor(index),
          onSelected: () {
            if (albums) {
              musicData.setCurrentAlbumIndex(index);
              final Album album = item as Album;
              gotoAlbumTrackList(context, musicData, album);
            } else {
              if (isAlbumTrackList) {
                musicData.setCurrentAlbumTrackIndex(index);
              } else {
                musicData.setCurrentTrackIndex(index);
              }
              final Track track = item as Track;
              goToNowPlaying(context, musicData, track);
            }
          },
        );
      },
    );
  }
}
