import 'package:flutter/material.dart';
import 'package:video_scroller/Screens/newHomeScren.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'videoScroller',
      home: HomeScreen(),
    );
  }
}
