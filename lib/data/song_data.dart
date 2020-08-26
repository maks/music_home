import 'dart:math';

import 'package:flute_music_player/flute_music_player.dart';

class MusicData {
  final List<Track> _tracks;
  final List<Album> _albums = [];
  int _currentSongIndex = -1;
  final MusicFinder musicFinder;

  MusicData(this._tracks, this.musicFinder) {
    _mapAlbums();
  }

  List<Track> get songs => _tracks;

  List<Album> get albums => _albums;

  int get length => _tracks.length;
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
    return _tracks[_currentSongIndex];
  }

  Track get randomSong {
    final r = Random();
    return _tracks[r.nextInt(_tracks.length)];
  }

  Track get prevSong {
    if (_currentSongIndex > 0) {
      _currentSongIndex--;
    }
    if (_currentSongIndex < 0) {
      return null;
    }
    return _tracks[_currentSongIndex];
  }

  MusicFinder get audioPlayer => musicFinder;

  void _mapAlbums() {
    final Map<String, Album> albumMap = <String, Album>{};
    for (final Track track in _tracks) {
      albumMap.putIfAbsent(
        track.album,
        () => Album(track.albumId, track.album, track.artist, track.albumArt),
      );
      albumMap[track.album].addTrack(track);
    }
    _albums.addAll(albumMap.values);
  }
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
  final List<Track> _tracks = [];

  List<Track> get tracks => _tracks.toList();

  Album(this.id, this.title, this.artist, this.albumArt);

  void addTrack(Track track) {
    _tracks.add(track);
    // keep tracks sorted by track number
    _tracks.sort((a, b) => a.trackNumber.compareTo(b.trackNumber));
  }

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
  final int trackNumber;

  Track(this.id, this.artist, this.title, this.album, this.albumId,
      this.duration, this.uri, this.albumArt, this.trackNumber);

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
