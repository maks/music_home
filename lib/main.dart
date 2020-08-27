import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music_home/data/music_data.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';
import 'utils/themes.dart';

void main() => runApp(MyMaterialApp());

class MyMaterialApp extends StatefulWidget {
  @override
  MyMaterialAppState createState() {
    return MyMaterialAppState();
  }
}

class MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MusicData>(
      create: (_) => MusicData(MusicFinder()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: MyApp(),
      ),
    );
  }
}
