import 'package:flutter/material.dart';
import 'package:maincra_api/pages/home.dart';
import 'package:maincra_api/services/item_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    loadAPI();

    return MaterialApp(
      debugShowCheckedModeBanner: false, //quitar debug
      title: 'MaincraApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Pantalla1(),
    );
  }
}

Future<void> loadAPI() async {
  await fetchItems();
}
