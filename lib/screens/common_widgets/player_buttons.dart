import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  PlayerButtons(this._audioPlayer,{Key? key}) : super(key: key);
   AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<bool>(
            stream: _audioPlayer.shuffleModeEnabledStream,
            builder: (context, snapshot) {
              return _shuffleButton(context, snapshot.data ?? false);
            }),
        StreamBuilder<SequenceState?>(
            stream: _audioPlayer.sequenceStateStream,
            builder: (_, __) {
              return _previousButton();
            }),
        StreamBuilder<PlayerState>(
            stream: _audioPlayer.playerStateStream,
            builder: (_, snapshot) {
              final playerState = snapshot.data;
              return _playPauseButton(playerState!);
            }),
        StreamBuilder<SequenceState?>(
            stream: _audioPlayer.sequenceStateStream,
            builder: (_, __) {
              return _nextButton();
            }),
        StreamBuilder<LoopMode>(
            stream: _audioPlayer.loopModeStream,
            builder: (context, snapshot) {
              return _repeatButton(context, snapshot.data ?? LoopMode.off);
            })
      ],
    );
  }

  _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await _audioPlayer.shuffle();
        }
        await _audioPlayer.setShuffleModeEnabled(enable);
      },
      icon: isEnabled
          ? Icon(
              Icons.shuffle,
              color: Theme.of(context).hintColor,
            )
          : Icon(Icons.shuffle),
    );
  }

  _previousButton() {
    return IconButton(
      onPressed: _audioPlayer.hasPrevious ? _audioPlayer.seekToPrevious : null,
      icon: Icon(Icons.skip_previous),
    );
  }

  _nextButton() {
    return IconButton(
      onPressed: _audioPlayer.hasNext ? _audioPlayer.seekToNext : null,
      icon: Icon(Icons.skip_next),
    );
  }

  _repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      Icon(Icons.repeat),
      Icon(
        Icons.repeat,
        color: Theme.of(context).hintColor,
      ),
      Icon(
        Icons.repeat_one,
        color: Theme.of(context).hintColor,
      ),
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
        onPressed: () {
          _audioPlayer.setLoopMode(cycleModes[
              (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
        },
        icon: icons[index]);
  }

  _playPauseButton(PlayerState playerState) {
    ///1 get the state
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      /// 2 if the player is in a temporary state, like loading and buffering,
      /// the button is replaced by a loading indicator;
      return Container(
        margin: EdgeInsets.all(8),
        width: 64,
        height: 64,
        child: CircularProgressIndicator(),
      );
    } else if (_audioPlayer.playing != true) {
      ///3if the audio player is not playing anything, which means that it is
      /// either paused or not started yet, the button is a play button that
      /// invokes the play()method on the audio player;
      return IconButton(
        onPressed: _audioPlayer.play,
        icon: Icon(Icons.play_arrow),
        iconSize: 64,
      );
    } else if (processingState != ProcessingState.completed) {
      ///4 if the state is not completed, then the audio player is playing
      ///one of the audio sources and the button is a pause button that
      /// invokes pause() on the audio player
      return IconButton(
        onPressed: _audioPlayer.pause,
        icon: Icon(Icons.pause),
        iconSize: 64,
      );
    } else {
      ///5 if all the above are not true, then the player has finished
      ///playing the sequence of audio sources, and it is still playing nothing,
      /// and the button is a replay button that moves the head of the player
      /// to the very beginning of the first audio source. Given that the player
      /// is playing, but it reached the end of the sequence,
      /// the music will start immediately, without the need to invoke an additional play().
      return IconButton(
        onPressed: () => _audioPlayer.seek(Duration.zero,
            index: _audioPlayer.effectiveIndices!.first),
        icon: Icon(Icons.replay),
        iconSize: 64,
      );
    }
  }
}
