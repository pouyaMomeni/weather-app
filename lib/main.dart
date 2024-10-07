import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherr/core/service_locator.dart';
import 'package:weatherr/presentation/screens/mainPage/main_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "RedditMono",
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
