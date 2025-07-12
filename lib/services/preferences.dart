
import 'package:shared_preferences/shared_preferences.dart';

String username = "username";
String pfp = "pfp";
String hbg = "homhBg";
String gridSize = "gridSize";


Future<String> loadProfileUser() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(username) ?? "New User";
}

Future<String> loadProfileImage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(pfp) ?? "assets/pfps/pfp3.gif";
}

Future<String> loadHomeBG() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(hbg) ?? "assets/bgs/bg1.png";
}

Future<int> loadGridSize() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(gridSize) ?? 3;
}

Future<void> saveProfileUser(String newUsername) async {
  final prefs = await SharedPreferences.getInstance();
  if (newUsername.isNotEmpty) { prefs.setString(username, newUsername); } 
  else { prefs.setString(username, "Empty Username"); }
}

Future<void> saveProfileImage(String newPfp) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(pfp, newPfp);
}

Future<void> saveHomeBG(String newHbg) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(hbg, newHbg);
}

Future<void> saveGridSize(int newGridSize) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(gridSize, newGridSize);
}
