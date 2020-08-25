import 'package:mockito/mockito.dart';
import 'package:music_home/data/song_data.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('albums match song list data', () {
    final songs = [
      Track.fromSong(Song.fromMap(<String, dynamic>{'albumId': 1})),
      Track.fromSong(Song.fromMap(<String, dynamic>{'albumId': 2})),
      Track.fromSong(Song.fromMap(<String, dynamic>{'albumId': 1})),
    ];

    final data = MusicData(songs, MockMusicFinder());

    expect(data.albums.length, 2);
  });
}

class MockMusicFinder extends Mock implements MusicFinder {}
