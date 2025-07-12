

import 'package:just_audio/just_audio.dart';

AudioPlayer buttonPlayer = AudioPlayer();
AudioPlayer chestClose1Player = AudioPlayer();
AudioPlayer chestOpenPlayer = AudioPlayer();
AudioPlayer enderChestOpenPlayer = AudioPlayer();
AudioPlayer enderChestClosePlayer = AudioPlayer();

class Audio {
  static Future<void> clearCache() async => AudioPlayer.clearAssetCache();
  static Future<void> loadButton() async => await buttonPlayer.setAsset("assets/audio/button_click.mp3");
  static Future<void> loadChestClose1() async => await chestClose1Player.setAsset("assets/audio/Chest_close1.ogg");
  static Future<void> loadChestOpen() async => await chestOpenPlayer.setAsset("assets/audio/Chest_open.ogg");
  static Future<void> loadEnderChestClose() async => enderChestClosePlayer.setAsset("assets/audio/Ender_Chest_close.ogg");
  static Future<void> loadEnderChestOpen() async => enderChestOpenPlayer.setAsset("assets/audio/Ender_Chest_open.ogg");

  static void button() { buttonPlayer.play(); loadButton(); }
  static void chestClose1() { chestClose1Player.play(); loadChestClose1(); }
  static void enderChestClose() { enderChestClosePlayer.play(); loadEnderChestClose(); }
  static void chestOpen() { chestOpenPlayer.play(); loadChestOpen(); }
  static void enderChestOpen() { enderChestOpenPlayer.play(); loadEnderChestOpen(); }

}