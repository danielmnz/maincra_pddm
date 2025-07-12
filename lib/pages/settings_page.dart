import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maincra_api/core/audio_player.dart';
import 'package:maincra_api/core/text_style.dart';
import 'package:maincra_api/core/widgets.dart';
import 'package:maincra_api/entity/profile.dart' as p;
import 'package:maincra_api/pages/home.dart';
import 'package:maincra_api/services/preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController usernameController;

  late String profileText = "loading...";
  late int profileIndex;
  late String hbgText = "loading...";
  late int hbgIndex;
  late int gridSize = 3;

  Future<void> getData() async {
    final profile = await loadProfileImage();
    final hbg = await loadHomeBG();
    final gridSize = await loadGridSize();
    setState(() {
      switch (profile) {
        case "assets/pfps/pfp1.gif":
          profileText = "Profile Picture: Creeper";
          profileIndex = 1;
          break;
        case "assets/pfps/pfp2.gif":
          profileText = "Profile Picture: Chair Steve";
          profileIndex = 2;
          break;
        case "assets/pfps/pfp3.gif":
          profileText = "Profile Picture: Zombie";
          profileIndex = 3;
          break;
      }

      switch (hbg) {
        case "assets/bgs/bg1.png":
          hbgText = "Home Background: Forest";
          hbgIndex = 1;
          break;
        case "assets/bgs/bg2.jpg":
          hbgText = "Home Background: Meadow";
          hbgIndex = 2;
          break;
        case "assets/bgs/bg3.jpg":
          hbgText = "Home Background: River";
          hbgIndex = 3;
          break;
        case "assets/bgs/bg4.jpg":
          hbgText = "Home Background: Swamp";
          hbgIndex = 4;
          break;
      }

      this.gridSize = gridSize;
    });
  }

  void updateProfileText(int index) {
    switch (index) {
      case 1:
        profileText = "Profile Picture: Creeper";
        break;
      case 2:
        profileText = "Profile Picture: Chair Steve";
        break;
      case 3:
        profileText = "Profile Picture: Zombie";
        break;
    }
  }

  void updateHBGText(int index) {
    switch (index) {
      case 1:
        hbgText = "Home Background: Forest";
        break;
      case 2:
        hbgText = "Home Background: Meadow";
        break;
      case 3:
        hbgText = "Home Background: River";
        break;
      case 4:
        hbgText = "Home Background: Swamp";
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    usernameController.text = p.p.getUsername;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(p.p.getHbg),
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                height: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/textfield_bg.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: usernameController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Your Username", // lol
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: 75,
                decoration: BoxDecoration(
                  image: AppCustomWidget.containerButton,
                ),
                child: TextButton(
                  child: Text(
                    profileText,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Audio.button();
                    if (profileIndex == 3) {
                      profileIndex = 1;
                    } else {
                      profileIndex++;
                    }

                    setState(() => updateProfileText(profileIndex));
                  },
                ),
              ),

              Container(
                height: 75,
                decoration: BoxDecoration(
                  image: AppCustomWidget.containerButton,
                ),
                child: TextButton(
                  child: Text(
                    hbgText,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Audio.button();
                    if (hbgIndex == 4) {
                      hbgIndex = 1;
                    } else {
                      hbgIndex++;
                    }

                    setState(() => updateHBGText(hbgIndex));
                  },
                ),
              ),

              Container(
                height: 75,
                decoration: BoxDecoration(
                  image: AppCustomWidget.containerButton,
                ),
                child: TextButton(
                  child: Text(
                    "Item Grid Size: $gridSize",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Audio.button();
                    setState(() {
                      if (gridSize == 5) {
                        gridSize = 3;
                      } else {
                        gridSize++;
                      }
                    });
                  },
                ),
              ),

              Container(
                height: 75,
                decoration: BoxDecoration(
                  image: AppCustomWidget.containerButton,
                ),
                child: TextButton(
                  child: Text(
                    "Clear Favorite Items Saved",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Audio.button();
                    showDialog(
                      barrierColor: Colors.black87,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.transparent,
                        title: Text(
                          "WARNING",
                          textAlign: TextAlign.center,
                          style: TextStyles.setWhiteColor,
                        ),
                        content: Text(
                          "This action cannot be unmade\n\n Are you sure?",
                          style: TextStyles.setWhiteColor,
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image:
                                        AppCustomWidget
                                            .containerSmallButton,
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      Audio.button();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image:
                                        AppCustomWidget
                                            .containerSmallButton,
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      "Confirm",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Map<String, dynamic> jsonData =
                                          await p.p.readJson();
                
                                      jsonData["favItems"].clear();
                                      p.p.getFavItems.clear();
                
                                      await p.p.saveJson(jsonData);
                                      Audio.button();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 75),

              Container(
                height: 75,
                decoration: BoxDecoration(
                  image: AppCustomWidget.containerButton,
                ),
                child: TextButton(
                  child: Text(
                    "Save Settings",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    p.p.changeUsername(usernameController.text);

                    String newProfile = "assets/pfps/pfp3.gif";
                    switch (profileIndex) {
                      case 1:
                        newProfile = "assets/pfps/pfp1.gif";
                        break;
                      case 2:
                        newProfile = "assets/pfps/pfp2.gif";
                        break;
                      case 3:
                        newProfile = "assets/pfps/pfp3.gif";
                        break;
                    }
                    p.p.changePfp(newProfile);

                    String newHBG = "assets/bgs/bg1.png";
                    switch (hbgIndex) {
                      case 1:
                        newHBG = "assets/bgs/bg1.png";
                        break;
                      case 2:
                        newHBG = "assets/bgs/bg2.jpg";
                        break;
                      case 3:
                        newHBG = "assets/bgs/bg3.jpg";
                        break;
                      case 4:
                        newHBG = "assets/bgs/bg4.jpg";
                        break;
                    }
                    p.p.changeHbg(newHBG);

                    p.p.changeGridSize(gridSize);

                    Audio.button();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
