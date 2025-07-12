
library;

import 'dart:convert';
import 'dart:io';

import 'package:maincra_api/entity/item.dart';
import 'package:maincra_api/services/preferences.dart';
import 'package:path_provider/path_provider.dart';

Profile p = Profile(
  "New User", 
  "assets/pfps/pfp2.gif", 
  "assets/bgs/bg1.png", 
  3,
  []
);

class Profile {
  String username;
  String pfp;
  String hbg;
  int gridSize;
  List<Item> favItems;

  Profile(this.username, this.pfp, this.hbg, this.gridSize, this.favItems);

  String get getUsername => username;
  String get getPfp => pfp;
  String get getHbg => hbg;
  int get getGridSize => gridSize;
  List<Item> get getFavItems => favItems;

  // Changers
  void changeUsername(String newUsername) {
    username = newUsername;
    saveProfileUser(newUsername);
  }
  void changePfp(String newPfp) {
    pfp = newPfp;
    saveProfileImage(newPfp);
  }
  void changeHbg(String newHbg) {
    hbg = newHbg;
    saveHomeBG(newHbg);
  }
  void changeGridSize(int newGridSize) {
    gridSize = newGridSize;
    saveGridSize(newGridSize);
  }

  // File Management
  Future<File> get _loadFile async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/favItems.json');

    if (!await file.exists()) {
      await file.writeAsString(jsonEncode({"favItems": []}));
      print("Filed Created.");
    }

    print("Found File.");

    return file;
  }
  Future<void> saveJson(Map<String, dynamic> jsonData) async {
    final file = await _loadFile;
    await file.writeAsString(jsonEncode(jsonData));
    print("File Saved.");
  }
  Future<Map<String, dynamic>> readJson() async {
    final file = await _loadFile;
    String content = await file.readAsStringSync();
    print("File Loaded.");
    return jsonDecode(content);
  }
  Future<void> loadFavItems() async {
    Map<String, dynamic> json = await readJson();

    if (favItems.isEmpty) {
      for (int i = 0; i < json["favItems"].length; i++) {
        favItems.add(Item(
          name: json["favItems"][i]['name'], 
          nameSpaceId: json["favItems"][i]['nameSpaceId'], 
          description: json["favItems"][i]['description'], 
          image: json["favItems"][i]['image'], 
          stackSize: json["favItems"][i]['stackSize'], 
          renewable: json["favItems"][i]['renewable']
        ));
      }
      print("Items Loaded from File.");
    }
  }


}