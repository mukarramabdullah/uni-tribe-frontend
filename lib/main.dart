import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tribe/app/mvvm/view/landing_views/landing_screen.dart';
import 'package:uni_tribe/app/config/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'University Landing',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: LandingScreen(),
      debugShowCheckedModeBanner: false,

      // Use the routes defined in AppPages
      getPages: AppPages.routes,
    );
  }
}
