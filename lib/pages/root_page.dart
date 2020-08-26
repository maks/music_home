import 'package:flutter/material.dart';
import 'package:music_home/widgets/now_playing_button.dart';

import '../widgets/mp_inherited.dart';
import '../widgets/mp_listview.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);

    //Shuffle Songs and goto now playing page
    void shuffleSongs() {
      // FIXME: need to move this into songdata
      //goToNowPlaying(rootIW.songData.randomSong);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Music Player'),
          actions: <Widget>[
            NowPlayingButton(),
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
