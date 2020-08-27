import 'package:mockito/mockito.dart';
// import 'package:music_home/data/music_data.dart';
import 'package:flute_music_player/flute_music_player.dart';
// import 'package:flutter_test/flutter_test.dart';

void main() {
  //FIXME: can't do this test for now is MusicFinder uses a static for allSongs() :-()

  // test('albums match song list data', () {
  //   final songs = [
  //     Track.fromSong(Song.fromMap(<String, dynamic>{'albumId': 1})),
  //     Track.fromSong(Song.fromMap(<String, dynamic>{'albumId': 2})),
  //     Track.fromSong(Song.fromMap(<String, dynamic>{'albumId': 1})),
  //   ];

  //   final mockFinder = MockMusicFinder();
  //   when(mockFinder.allSongs()).thenAnswer((_) => songs);

  //   final data = MusicData(mockFinder);

  //   expect(data.albums.length, 2);
  // });
}

class MockMusicFinder extends Mock implements MusicFinder {}
