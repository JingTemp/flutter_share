import 'package:flutter/material.dart';
import 'package:flutter_share/doc_page.dart';
import 'package:flutter_share/game_page.dart';
import 'package:flutter_share/verse_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;
  static const TextStyle optionsStyle = TextStyle(fontSize: 30,fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    VersePage(),
    GamePage(),
    DocPage(),
  ];
  void _onItemTaped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex),),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('诗文'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.games),
              title: Text('游戏'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              title: Text('文档'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigo,
          onTap: _onItemTaped,
        ),
      ),
    );
  }
}