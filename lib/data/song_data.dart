import 'dart:math';

import 'package:flute_music_player/flute_music_player.dart';

import '../extensions.dart';

class MusicData {
  final List<Track> _songs;
  int _currentSongIndex = -1;
  final MusicFinder musicFinder;

  MusicData(this._songs, this.musicFinder);

  List<Track> get songs => _songs;

  List<Album> get albums => _songs
      .map(
          (song) => Album(song.albumId, song.album, song.artist, song.albumArt))
      .toList()
      .distinct();

  int get length => _songs.length;
  int get songNumber => _currentSongIndex + 1;

  void setCurrentIndex(int index) {
    _currentSongIndex = index;
  }

  int get currentIndex => _currentSongIndex;

  Track get nextSong {
    if (_currentSongIndex < length) {
      _currentSongIndex++;
    }
    if (_currentSongIndex >= length) {
      return null;
    }
    return _songs[_currentSongIndex];
  }

  Track get randomSong {
    final r = Random();
    return _songs[r.nextInt(_songs.length)];
  }

  Track get prevSong {
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

abstract class MusicItem {
  int get id;
  String get title;
  String get artist;
  String get albumArt;
}

class Album implements MusicItem {
  @override
  final int id;
  @override
  final String title;
  @override
  final String artist;
  @override
  final String albumArt;

  Album(this.id, this.title, this.artist, this.albumArt);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is Album && o.title == title;
  }

  @override
  int get hashCode => id.hashCode;
}

class Track implements MusicItem {
  @override
  final int id;
  @override
  final String artist;
  @override
  final String title;
  @override
  final String albumArt;
  final String album;
  final int albumId;
  final int duration;
  final String uri;
  final int trackId;

  Track(this.id, this.artist, this.title, this.album, this.albumId,
      this.duration, this.uri, this.albumArt, this.trackId);

  factory Track.fromSong(Song s) {
    return Track(
      s.id,
      s.artist,
      s.title,
      s.album,
      s.albumId,
      s.duration,
      s.uri,
      s.albumArt,
      s.trackId,
    );
  }
}
