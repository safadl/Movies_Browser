import 'package:flutter/material.dart';
import 'package:movies_browser/favoritesScreen.dart';
import 'package:movies_browser/getImages.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final String title = "";

  static List<Widget> _children = [
    MoviesScreen(title: 'Movies'),
    FavoriteScreen(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          tooltip: 'Open menu',
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Open menu',
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        centerTitle: true,
        title: Text(title),
      ),
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          selectedItemColor: Colors.redAccent[700],
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: false,
          // backgroundColor: Colors.grey[800],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark_outline,
                ),
                label: 'Favorites',
                backgroundColor: Colors.pink),
          ]),
    );
  }
}
