import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playlistView/playlist_view.dart';
import 'playingView/playing_view.dart';
import '../../providers/song_provider.dart';
import './menu_styles.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Listeners
    final songProvider = context.read<SongProvider>();
    songProvider.player.onPlayerComplete.listen((_) {
        songProvider.nextSong();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: appBarTitle,
          titleTextStyle: appBarTextStyle,
          backgroundColor: appBarBgColor,
          centerTitle: true,
          shape: appBarShape,
        ),
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (int index) {
            setState(() {
              currentSelectedIndex = index;
            });
          },
          selectedIndex: currentSelectedIndex,
          indicatorColor: bottomNavBarIndicatorColor, // BottomNavBarIndicatorColor
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.my_library_music_rounded),
              icon: Icon(Icons.my_library_music_outlined),
              label: 'Librería',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.album_rounded),
              icon: Icon(Icons.album_outlined),
              label: 'Sonando',
            ),
          ],
        ),
        body: <Widget>[
          PlaylistView(),
          PlayingView()
        ][currentSelectedIndex]
      )
    );
  }
}