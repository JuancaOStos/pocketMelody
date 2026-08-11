import 'dart:typed_data';
import 'package:duration/duration.dart';

class Song {
  final String _title;
  final String _album;
  final String _artist;
  final Duration _duration;
  final String _path;
  final Uint8List? _cover;

  const Song({
    required this._title,
    required this._album,
    required this._artist,
    required this._duration,
    required this._path,
    this._cover,
  });

  String get title => _title;
  String get album => _album;
  String get artist => _artist;
  Duration get duration => _duration;
  String get path => _path;
  Uint8List? get cover => _cover;

  String formatDuration() {
    String procesedDuration = _duration.pretty(
      abbreviated: true,
      delimiter: ':'
    );
    List<String> durationUnits = procesedDuration.split(':');
    if (durationUnits.length < 2) {
      durationUnits.add(durationUnits[0]);
      durationUnits[0] = '00';
    }
    
    for (int i = 0; i < durationUnits.length; i++) {
      durationUnits[i] = durationUnits[i]
          .replaceAll(' min', '')
          .replaceAll(' s', '');
      if (durationUnits[i].length < 2) {
        durationUnits[i] = '0${durationUnits[i]}';
      }
    }
    
    procesedDuration = durationUnits.join(':');
    return procesedDuration;
  }
}