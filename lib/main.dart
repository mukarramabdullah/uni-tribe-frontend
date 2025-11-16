import 'package:flutter/material.dart';
import 'package:uni_tribe/app/mvvm/view/landing_views/landing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Landing',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: LandingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
