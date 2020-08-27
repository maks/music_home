import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/music_data.dart';
import 'navigation_routes.dart';

class NowPlayingButton extends StatelessWidget with NavigatationRoutes {
  @override
  Widget build(BuildContext context) {
    final musicData = Provider.of<MusicData>(context);
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: InkWell(
            child: Text('Now Playing'),
            onTap: () => goToNowPlaying(
                  context,
                  musicData,
                  musicData.currentlyPlayingTrack,
                  nowPlayTap: true,
                )),
      ),
    );
  }
}
