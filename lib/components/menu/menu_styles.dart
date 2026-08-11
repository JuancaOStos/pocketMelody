import 'package:flutter/material.dart';

const Text appBarTitle = Text('Pocket Melody');
const TextStyle appBarTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20
);
const Color appBarBgColor = Color(0xFF0F3040);
const RoundedRectangleBorder appBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadiusGeometry.directional(
    bottomStart: Radius.circular(12.5),
    bottomEnd: Radius.circular(12.5)
  )
);
const Color bottomNavBarIndicatorColor = Color(0x00000000);