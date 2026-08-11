import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_melody/providers/song_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'components/menu/menu.dart';

void main() async {
  // Window settings
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setResizable(false);
  await windowManager.setMaximizable(false);

  WindowOptions windowOptions = WindowOptions(
    size: Size(500, 800),
    center: true
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SongProvider(),
      child: Menu()
    );
  }
}