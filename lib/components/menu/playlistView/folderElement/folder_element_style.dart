import 'package:flutter/material.dart';

final ButtonStyle buttonStyle = FilledButton.styleFrom(
  backgroundColor: Color(0x00000000),
  padding: const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 20
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0)
  )
);
const double iconSize = 60;
const double folderDataWidth = 200;
const TextScaler folderNameScale = TextScaler.linear(1.5);