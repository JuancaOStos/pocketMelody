import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pocket_melody/classes/song.dart';
import 'package:pocket_melody/classes/folder.dart';
import 'dart:io';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:audioplayers/audioplayers.dart';

class SongProvider extends ChangeNotifier {
  // Carpeta principal desde la que puedes navegar
  final String mainFolder = 'C:\\Users\\FLUTTER\\Music';
  final AudioPlayer _player = AudioPlayer();
  
  // Directorio actual sobre el que te encuentras actualmente
  String _currentFolder = 'C:\\Users\\FLUTTER\\Music';

  // Carpetas disponibles en el directorio actual
  final List<Folder> _folderDataList = [];
  // Canciones disponibles en el directorio actual
  final List<Song> _metaPlaylist = [];
  // Directorio actualmente reproduciéndose
  String _playingFolder = '';
  // Canciones actualmente reproduciéndose
  List<Song> _playingMetaPlaylist = [];
  // Índice de la canción que se está reproduciendo ahora
  int _playingSongIndex = 0;

  // Getters
  String get currentFolder      => _currentFolder;
  List<Folder> get folderDataList  => _folderDataList;
  List<Song> get metaPlaylist  => _metaPlaylist;
  String get playingFolder => _playingFolder;
  List<Song> get playingMetaPlaylist => _playingMetaPlaylist;
  int get playingSongIndex              => _playingSongIndex;
  AudioPlayer get player => _player;

  // Método que cambia el directorio actual por el de la carpeta seleccionada
  void openFolder(String pathFolder) async {
    _currentFolder = pathFolder;
    await getFilesData();
  }

  // Método que cambia el índice de la canción que se reproduce actualmente
  Future<void> selectSong(int songIndex) async {
    _playingMetaPlaylist = _metaPlaylist.map((song) => song).toList();
    _playingFolder = _currentFolder;
    _playingSongIndex = songIndex;
    //_player.setSource(DeviceFileSource(_playingMetaPlaylist[_playingSongIndex].path));
    //print('Índice seleccionado: $playingSongIndex');
    _player.play(DeviceFileSource(_playingMetaPlaylist[_playingSongIndex].path));
    notifyListeners();
  }

  // Método para pasar a la canción siguiente en el listado actual
  void nextSong() {
    if (_playingSongIndex < _playingMetaPlaylist.length-1) {
      _playingSongIndex++;
    } else {
      _playingSongIndex = 0;
    }
    _player.play(DeviceFileSource(_playingMetaPlaylist[_playingSongIndex].path));
    notifyListeners();
  }

  void pauseSong() {
    _player.pause();
  }

  // Método para pasar a la canción anterior en el listado actual
  void previousSong() {
    if (_playingSongIndex > 0) {
      _playingSongIndex--;
    }
    else {
      _playingSongIndex = _playingMetaPlaylist.length-1;
    }
    _player.play(DeviceFileSource(_playingMetaPlaylist[_playingSongIndex].path));
    notifyListeners();
  }

  Future<void> getFilesData() async {
    folderDataList.clear();
    metaPlaylist.clear();
    List<FileSystemEntity> files = Directory(_currentFolder).listSync();

    for (final file in files) {
      const List<String> allowedFormats = ['.flac', '.mp3', '.wav']; // Guardar a futuro en archivo de constantes
      bool isAllowed = false;
      for (String format in allowedFormats) {
        if (file.path.contains(format)) {
          isAllowed = true;
          break;
        }
      }
      if (file is File && isAllowed) {
        final metadata = readMetadata(file, getImage: true);

        Song song = Song(
          title: metadata.title ?? 'Título desconocido',
          album: metadata.album ?? 'Álbum desconocido',
          artist: metadata.artist ?? 'Artista desconocido',
          duration: metadata.duration ?? Duration(),
          path: file.path,
          cover: metadata.pictures[0].bytes
        );
        _metaPlaylist.add(song);
      }
      if (file is Directory) {
        String path = file.path;
        String title = file.path.split('\\')[file.path.split('\\').length-1];

        Folder folder = Folder(
          path: path,
          name: title
        );
        _folderDataList.add(folder);
      }
    }
    notifyListeners();
  }

  void setPlayerSource(String path) {
    _player.setSource(DeviceFileSource(path));
  }

  Future<void> playSong() async {
    await _player.resume();
  }

  Future<void> setPosition(Duration duration) async {
    await _player.seek(duration);
  }
}