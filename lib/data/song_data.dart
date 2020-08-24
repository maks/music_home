import 'dart:math';

import 'package:flute_music_player/flute_music_player.dart';

class SongData {
  final List<Song> _songs;
  int _currentSongIndex = -1;
  MusicFinder musicFinder;
  SongData(this._songs) {
    musicFinder = MusicFinder();
  }

  List<Song> get songs => _songs;
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
