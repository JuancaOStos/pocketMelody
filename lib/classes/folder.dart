class Folder {
  final String _path;
  final String _name;

  const Folder({
    required this._path,
    required this._name
  });

  String get path => _path;
  String get name => _name;
}