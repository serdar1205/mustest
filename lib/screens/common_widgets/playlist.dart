import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Playlist extends StatelessWidget {
  Playlist(this._audioPlayer, {Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _audioPlayer.sequenceStateStream,
        builder: (context, snapshot){
          final state = snapshot.data;
          final sequence = state?.sequence ?? [];
          if(state == null) return const CircularProgressIndicator();
          return ListView(
            children: [
              for(var i = 0; i < sequence.length; i++)
                ListTile(
                  selected: i == state.currentIndex,
                  leading: Image.network(sequence[i].tag.image),
                  title: Text(sequence[i].tag.title),
                  onTap: (){
                    _audioPlayer.seek(Duration.zero,index: i);
                  },
                )
            ],
          );
        });
  }
}
