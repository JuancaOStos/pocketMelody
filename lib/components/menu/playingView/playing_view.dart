import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_melody/providers/song_provider.dart';
import 'package:pocket_melody/classes/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'playing_view_style.dart';

class PlayingView extends StatefulWidget {

  const PlayingView({super.key});

  @override
  State<PlayingView> createState() => _PlayingViewState();
}

class _PlayingViewState extends State<PlayingView> {
  PlayerState currentSongState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();

    context.read<SongProvider>().player.onPlayerStateChanged.listen((state) {
      setState(() {
        currentSongState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = context.watch<SongProvider>();

    Song playingSong = Song (
      title: 'Desconocida',
      album: 'Desconocido',
      artist: 'Desconocido',
      duration: Duration(),
      path: '',
      cover: null
    );
    if (songProvider.playingMetaPlaylist.isNotEmpty) {
      int songIndex = songProvider.playingSongIndex;
      playingSong = songProvider.playingMetaPlaylist[songIndex];
    }
    
    return Column(
      spacing: columnSpacing,
      children: [
        SizedBox(
          height: marginTop,
        ),
        ClipRRect(
          borderRadius: coverBorderRadius,
          child: 
            playingSong.cover != null
            ? Image.memory(playingSong.cover!, scale: coverScale)
            : Icon(Icons.question_mark)
        ),
        Column(
          children: [
            Text(playingSong.title, textScaler: titleScale),
            Text('${playingSong.album} - ${playingSong.artist}', textScaler: albumArtistScale),
          ]
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: progressBarScale,
          child: StreamBuilder(
            stream: songProvider.player.onPositionChanged,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;

              return ProgressBar(
                progress: position,
                total: playingSong.duration,
                onSeek: songProvider.playingMetaPlaylist.isNotEmpty ? (duration) {
                  songProvider.setPosition(duration);
                } : (_) {
                  songProvider.setPosition(Duration(seconds: 0));
                },
              );
            },
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: buttonSpacing,
          children: [
            IconButton.filledTonal(
              onPressed: () {
                songProvider.previousSong();
              },
              color: buttonColor,
              style: IconButton.styleFrom(
                backgroundColor: buttonBgColor
              ),
              icon: Icon(Icons.skip_previous_rounded),
              iconSize: iconButtonSize
            ),
            IconButton.filled(
              onPressed: () {
                if (songProvider.player.state == PlayerState.paused) {
                  songProvider.player.resume();
                } else {
                  songProvider.player.pause();
                }
              },
              color: buttonColor,
              style: IconButton.styleFrom(
                backgroundColor: buttonBgColor
              ),
              icon: currentSongState == PlayerState.paused
                ? Icon(Icons.play_arrow_rounded)
                : Icon(Icons.pause)
              ,
              iconSize: playIconButtonSize
            ),
            IconButton.filledTonal(
              onPressed: () {
                songProvider.nextSong();
              },
              color: buttonColor,
              style: IconButton.styleFrom(
                backgroundColor: buttonBgColor
              ),
              icon: Icon(Icons.skip_next_rounded),
              iconSize: iconButtonSize
            ),
          ],
        ),
      ],
    );
  } 
}