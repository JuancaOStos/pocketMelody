import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_melody/providers/song_provider.dart';
import 'folder_element_style.dart';

class FolderElement extends StatelessWidget {
  final String path;
  final String name;
  final bool goBack;

  const FolderElement({
    required this.path,
    required this.name,
    required this.goBack,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton.tonal(
          onPressed: () {
            context.read<SongProvider>().openFolder(path);
          },
          style: buttonStyle,
          child: Row(
            spacing: 20,
            children: [
              goBack
              ? Icon(Icons.arrow_back_rounded, size: iconSize)
              : Icon(Icons.folder, size: iconSize),
              SizedBox(
                width: folderDataWidth,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    textScaler: folderNameScale
                  )
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}