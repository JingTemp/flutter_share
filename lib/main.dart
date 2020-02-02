import 'package:flutter/material.dart';

import 'splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 分享',
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}