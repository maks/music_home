import 'dart:io';

import 'package:flutter/material.dart';

import '../data/song_data.dart';
import '../pages/now_playing.dart';
import 'mp_circle_avatar.dart';
import 'mp_inherited.dart';

class MPListView extends StatelessWidget {
  final List<MaterialColor> _colors = Colors.primaries;
  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);
    final SongData songData = rootIW.songData;
    return ListView.builder(
      itemCount: songData.songs?.length ?? 0,
      itemBuilder: (context, int index) {
        final s = songData.songs[index];
        final MaterialColor color = _colors[index % _colors.length];
        final artFile =
            s.albumArt == null ? null : File.fromUri(Uri.parse(s.albumArt));

        return ListTile(
          dense: false,
          leading: Hero(
            child: avatar(artFile, s.title, color),
            tag: s.title,
          ),
          title: Text(s.title),
          subtitle: Text(
            'By ${s.artist}',
            style: Theme.of(context).textTheme.caption,
          ),
          onTap: () {
            songData.setCurrentIndex(index);
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => NowPlaying(songData, s),
              ),
            );
          },
        );
      },
    );
  }
}
