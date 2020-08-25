import 'package:flutter/material.dart';
import 'package:music_home/data/song_data.dart';

import '../widgets/mp_inherited.dart';
import '../widgets/mp_listview.dart';
import 'now_playing.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);
    //Goto Now Playing Page
    void goToNowPlaying(Track s, {bool nowPlayTap: false}) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => NowPlaying(
            rootIW.songData,
            s,
            nowPlayTap: nowPlayTap,
          ),
        ),
      );
    }

    //Shuffle Songs and goto now playing page
    void shuffleSongs() {
      goToNowPlaying(rootIW.songData.randomSong);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(tabs: [
            Tab(text: 'All Songs'),
            Tab(text: 'Albums'),
          ]),
        ),
        body: TabBarView(
          children: [
            rootIW.isLoading
                ? Center(child: CircularProgressIndicator())
                : Scrollbar(child: MPListView(rootIW.songData, false)),
            rootIW.isLoading
                ? Center(child: CircularProgressIndicator())
                : Scrollbar(child: MPListView(rootIW.songData, true)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.shuffle), onPressed: () => shuffleSongs()),
      ),
    );
  }
}
