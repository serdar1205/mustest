import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mustest/model/audio_model.dart';
import 'package:mustest/screens/common_widgets/playlist.dart';
import '../model/playlist_item.dart';
import 'common_widgets/player_buttons.dart';

class Player extends StatelessWidget {
  final AudioPlayer _audioPlayer;
  final List<PlaylistItem> _playlist;

   Player(this._audioPlayer,this._playlist,{Key? key}) : super(key: key){
     if(!_audioPlayer.playing) _loadAudioSource(_playlist);
   }


  void _loadAudioSource(List<PlaylistItem> playlist) {
    _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: playlist
            .map(
              (e) => AudioSource.uri(
                e.itemLocation,
                tag: AudioMetadata(
                    title: e.title, image: e.artworkUri.toString()),
              ),
            )
            .toList(),
      ),
    ).catchError((error){
      print("An error occured $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: Playlist(_audioPlayer)),
              PlayerButtons(_audioPlayer),
            ],
          )
        ),
      ),
    );
  }
}
