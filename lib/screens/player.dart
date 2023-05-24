import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'common_widgets/player_buttons.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")),
      AudioSource.uri(Uri.parse(
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3")),
      AudioSource.uri(Uri.parse(
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"))
    ]))
        .catchError((error) {
      print("An error occured $error");
    });
  }

  void getAudioSource() async {}



  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<PlayerState>(
          stream: _audioPlayer.playerStateStream,
          builder: (context, snapshot){
            final playerState = snapshot.data;
            return PlayerButtons(_audioPlayer);
          },
        ),
      ),
    );
  }
}
