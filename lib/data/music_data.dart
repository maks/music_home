import 'dart:math';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/foundation.dart';

class MusicData extends ChangeNotifier {
  List<Track> _tracks;
  final List<Album> _albums = [];
  int _currentTrackIndex = -1;
  int _currentAlbumIndex = -1;
  int _currentAlbumTrackIndex = 0;
  final MusicFinder musicFinder;

  MusicData(this.musicFinder) {
    _getAllTracks().then((value) {
      _mapAlbums();
      notifyListeners();
    });
  }

  List<Track> get tracks => _tracks;

  List<Album> get albums => _albums;

  int get length => _tracks.length;
  int get trackNumber => _currentTrackIndex + 1;

  Album get currentAlbum => _albums[_currentAlbumIndex];

  bool get isPlayingAlbum => _currentAlbumIndex != -1;

  Track get _currentAlbumTrack => currentAlbum.tracks[_currentAlbumTrackIndex];

  Track get currentlyPlayingTrack =>
      isPlayingAlbum ? _currentAlbumTrack : _tracks[_currentTrackIndex];

  void setCurrentTrackIndex(int index) {
    _currentTrackIndex = index;
    // clear current album when starting to play new track from all tracks list
    _currentAlbumIndex = -1;
  }

  void setCurrentAlbumIndex(int index) {
    _currentAlbumIndex = index;
    // reset back to 1st album track each time we change album
    _currentAlbumTrackIndex = 0;
  }

  void setCurrentAlbumTrackIndex(int albumTrackIndex) {
    _currentAlbumTrackIndex = albumTrackIndex;
  }

  int get currentIndex => _currentTrackIndex;

  Track get nextTrack {
    if (_currentAlbumIndex != -1) {
      if (_currentAlbumTrackIndex < currentAlbum.tracks.length) {
        _currentAlbumTrackIndex++;
      }
      if (_currentAlbumTrackIndex >= currentAlbum.tracks.length) {
        return null;
      }
      return currentAlbum.tracks[_currentAlbumTrackIndex];
    } else {
      if (_currentTrackIndex < length) {
        _currentTrackIndex++;
      }
      if (_currentTrackIndex >= length) {
        return null;
      }
      return _tracks[_currentTrackIndex];
    }
  }

  Track get randomTrack {
    final r = Random();
    return _tracks[r.nextInt(_tracks.length)];
  }

  Track get prevTrack {
    if (_currentAlbumIndex != -1) {
      if (_currentAlbumTrackIndex > 0) {
        _currentAlbumTrackIndex--;
      }
      if (_currentAlbumTrackIndex < 0) {
        return null;
      }
      return currentAlbum.tracks[_currentAlbumTrackIndex];
    } else {
      if (_currentTrackIndex > 0) {
        _currentTrackIndex--;
      }
      if (_currentTrackIndex < 0) {
        return null;
      }
      return _tracks[_currentTrackIndex];
    }
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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _getAllTracks() async {
    List<Track> songs;
    try {
      songs = (await MusicFinder.allSongs() as List<Song>)
          .map((s) => Track.fromSong(s))
          .toList();
    } catch (e) {
      print("Failed to get songs: '$e'.");
    }
    _tracks = songs;
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
