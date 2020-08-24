import 'package:flute_example/data/song_data.dart';
import 'package:flutter/material.dart';

class MPInheritedWidget extends InheritedWidget {
  final SongData songData;
  final bool isLoading;

  const MPInheritedWidget(this.songData, this.isLoading, child)
      : super(child: child);

  static MPInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MPInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MPInheritedWidget oldWidget) =>
      songData != oldWidget.songData || isLoading != oldWidget.isLoading;
}
