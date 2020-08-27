import 'package:flutter/material.dart';
import 'package:music_home/data/music_data.dart';
import 'package:provider/provider.dart';

import '../widgets/mp_listview.dart';
import '../widgets/now_playing_button.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MusicData musicData = Provider.of<MusicData>(context);

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
            (musicData == null)
                ? Center(child: CircularProgressIndicator())
                : Scrollbar(child: MPListView(musicData, false)),
            musicData == null
                ? Center(child: CircularProgressIndicator())
                : Scrollbar(child: MPListView(musicData, true)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.shuffle), onPressed: () => shuffleSongs()),
      ),
    );
  }
}
