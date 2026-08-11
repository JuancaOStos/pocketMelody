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
final BorderRadiusGeometry coverBorderRadius = BorderRadius.circular(5);
const double coverScale = 12;
const double songDataWidth = 200;
const TextScaler titleTextScale = TextScaler.linear(1.5);
const TextScaler albumArtistScale = TextScaler.linear(1);