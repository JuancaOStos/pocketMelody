import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'songElement/song_element.dart';
import 'folderElement/folder_element.dart';
import 'package:pocket_melody/providers/song_provider.dart';
import '../../../classes/song.dart';
import '../../../classes/folder.dart';
import 'dart:io';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  bool isMainFolder = false;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SongProvider>().getFilesData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = context.watch<SongProvider>();
    Directory currentFolder = Directory(songProvider.currentFolder);
    isMainFolder = currentFolder.path == songProvider.mainFolder;
    List<Song> metadataSongList = songProvider.metaPlaylist;
    List<Folder> folderDataList = songProvider.folderDataList;
    return ListView(
      children: [
        !isMainFolder
        ? FolderElement(
            path: currentFolder.parent.path,
            name: 'Volver',
            goBack: !isMainFolder,
          )
        : Container(),
        ...folderDataList.asMap().entries.map((entry) {
          final Folder folder = entry.value;
          return FolderElement(
            path: folder.path,
            name: folder.name,
            goBack: false);
        }),
        ...metadataSongList.asMap().entries.map((entry) {
          final int songId = entry.key;
          final Song song = entry.value;
          return SongElement(
            songId: songId,
            title: song.title,
            album: song.album,
            artist: song.artist,
            cover: song.cover!,
            selected: songProvider.currentFolder == songProvider.playingFolder
                   && songProvider.playingSongIndex == songId,
        );
      })
      ]
    );
  }
}