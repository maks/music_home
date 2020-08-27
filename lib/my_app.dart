import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/music_data.dart';
import 'pages/root_page.dart';

class MyApp extends StatefulWidget {
  static MaterialColor randomPrimaryColor(int index) =>
      Colors.primaries[index % Colors.primaries.length];

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MusicData musicData;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    musicData.audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return RootPage();
  }
}
