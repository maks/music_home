import 'dart:math';

import 'package:flute_music_player/flute_music_player.dart';

import '../extensions.dart';

class SongData {
  final List<Song> _songs;
  int _currentSongIndex = -1;
  final MusicFinder musicFinder;

  SongData(this._songs, this.musicFinder);

  List<Song> get songs => _songs;

  List<Album> get albums =>
      _songs.map((song) => Album(song.albumId, song.album)).toList().distinct();

  int get length => _songs.length;
  int get songNumber => _currentSongIndex + 1;

  void setCurrentIndex(int index) {
    _currentSongIndex = index;
  }

  int get currentIndex => _currentSongIndex;

  Song get nextSong {
    if (_currentSongIndex < length) {
      _currentSongIndex++;
    }
    if (_currentSongIndex >= length) {
      return null;
    }
    return _songs[_currentSongIndex];
  }

  Song get randomSong {
    final r = Random();
    return _songs[r.nextInt(_songs.length)];
  }

  Song get prevSong {
    if (_currentSongIndex > 0) {
      _currentSongIndex--;
    }
    if (_currentSongIndex < 0) {
      return null;
    }
    return _songs[_currentSongIndex];
  }

  MusicFinder get audioPlayer => musicFinder;
}

class Album {
  final int id;
  final String name;

  Album(this.id, this.name);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is Album && o.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
