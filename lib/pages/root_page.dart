import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

import '../widgets/mp_inherited.dart';
import '../widgets/mp_lisview.dart';
import 'now_playing.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);
    //Goto Now Playing Page
    void goToNowPlaying(Song s, {bool nowPlayTap: false}) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NowPlaying(
                    rootIW.songData,
                    s,
                    nowPlayTap: nowPlayTap,
                  )));
    }

    //Shuffle Songs and goto now playing page
    void shuffleSongs() {
      goToNowPlaying(rootIW.songData.randomSong);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Music Player'),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: InkWell(
                  child: Text('Now Playing'),
                  onTap: () => goToNowPlaying(
                        rootIW.songData.songs[
                            (rootIW.songData.currentIndex == null ||
                                    rootIW.songData.currentIndex < 0)
                                ? 0
                                : rootIW.songData.currentIndex],
                        nowPlayTap: true,
                      )),
            ),
          )
        ],
      ),
      // drawer: MPDrawer(),
      body: rootIW.isLoading
          ? Center(child: CircularProgressIndicator())
          : Scrollbar(child: MPListView()),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shuffle), onPressed: () => shuffleSongs()),
    );
  }
}
