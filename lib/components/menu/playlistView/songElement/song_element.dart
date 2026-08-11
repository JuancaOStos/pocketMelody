import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_melody/providers/song_provider.dart';
import 'dart:typed_data';
import 'song_element_style.dart';

class SongElement extends StatelessWidget {
  final int songId;
  final String title;
  final String album;
  final String artist;
  final Uint8List cover;
  final bool selected;

  const SongElement({
    required this.songId,
    required this.title,
    required this.album,
    required this.artist,
    required this.cover,
    required this.selected,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton.tonal(
          onPressed: () {
            context.read<SongProvider>().selectSong(songId);
          },
          style: buttonStyle,
          child: Row(
            spacing: 20,
            children: [
              ClipRRect(
                borderRadius: coverBorderRadius,
                child: Image.memory(
                  cover,
                  scale: coverScale
                )
              ),
              SizedBox(
                width: songDataWidth,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        textScaler: titleTextScale
                      )
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$album - $artist',
                        textScaler: albumArtistScale
                      )
                    )
                  ]
                )
              ),
              selected
              ? Icon(Icons.music_note_rounded)
              : Container()
            ],
          ),
        )
      ],
    );
  }
}