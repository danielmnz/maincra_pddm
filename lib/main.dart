import 'package:flutter/material.dart';
import 'package:maincra_api/core/text_style.dart';
import 'package:maincra_api/pages/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaincraApp',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFC6C6C6),
        appBarTheme: AppBarTheme(
          toolbarHeight: 70,
          centerTitle: true,
          titleTextStyle: TextStyles.appBarTitle,
          backgroundColor: Color(0xFFC6C6C6),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: Colors.black
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        fontFamily: "Mojangles",
      ),
      home: Home(),
    );
  }
}

