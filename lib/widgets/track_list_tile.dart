import 'dart:io';

import 'package:flutter/material.dart';

import 'mp_circle_avatar.dart';

class SongListTile extends StatelessWidget {
  final String title;
  final String artist;
  final File artFile;
  final MaterialColor color;
  final void Function() onSelected;

  SongListTile({
    @required this.title,
    @required this.artist,
    @required this.artFile,
    @required this.color,
    @required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      leading: Hero(
        child: avatar(artFile, title, color),
        tag: title,
      ),
      title: Text(title),
      subtitle: Text(
        'By ${artist}',
        style: Theme.of(context).textTheme.caption,
      ),
      onTap: onSelected,
    );
  }
}
