import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/song_data.dart';
import 'pages/root_page.dart';
import 'widgets/mp_inherited.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SongData songData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    songData.audioPlayer.stop();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void initPlatformState() async {
    _isLoading = true;

    List<Song> songs;
    try {
      songs = await MusicFinder.allSongs() as List<Song>;
    } catch (e) {
      print("Failed to get songs: '$e'.");
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      songData = SongData(songs);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPInheritedWidget(
      songData,
      _isLoading,
      RootPage(),
    );
  }
}
