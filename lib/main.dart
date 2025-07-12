import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maincra_api/core/audio_player.dart';
import 'package:maincra_api/core/text_style.dart';
import 'package:maincra_api/entity/profile.dart' as p;
import 'package:maincra_api/pages/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Audio.clearCache();
    Audio.loadButton();
    Audio.loadChestClose1();
    Audio.loadEnderChestClose();
    Audio.loadChestOpen();
    Audio.loadEnderChestOpen();
    p.p.loadFavItems();

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
      home: PopScope(
        canPop: false,
        child: Home()
      ),
    );
  }
}

