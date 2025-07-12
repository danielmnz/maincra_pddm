import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maincra_api/core/audio_player.dart';
import 'package:maincra_api/core/widgets.dart';
import 'package:maincra_api/entity/profile.dart' as p;
import 'package:maincra_api/pages/items_page.dart';
import 'package:maincra_api/pages/my_items_page.dart';
import 'package:maincra_api/pages/settings_page.dart';
import 'package:maincra_api/services/preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String randomCommandBlock = "assets/impulse_command_block.gif";

  String getCommandBlock() {
    var rand = Random().nextInt(3);
    switch (rand) {
      case 0: return "assets/impulse_command_block.gif"; 
      case 1: return "assets/chain_command_block.gif"; 
      case 2: return "assets/repeat_command_block.gif"; 
    }

    return "assets/impulse_command_block.gif";
  }

  Future<void> loadData() async {
    String username = await loadProfileUser();
    String pfp = await loadProfileImage();
    String hbg = await loadHomeBG();
    int gridSize = await loadGridSize();

    setState(() {
      p.p.changeUsername(username);
      p.p.changePfp(pfp);
      p.p.changeHbg(hbg);
      p.p.changeGridSize(gridSize);
    });
  }

  @override
  void initState() {
    randomCommandBlock = getCommandBlock();
    loadData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 60),
            SizedBox(width: 8),
            Text("Item Guide"),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(p.p.getHbg),
            fit: BoxFit.cover,
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height
          ),
          child: ListView(
            // shrinkWrap: true,
            children: [
              // User Card
              Padding(
                padding: const EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: 210,
                  ),
                  child: Row(
                    children: [
                      // PFP ===[ DO NOT CHANGE ]===
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          width: (MediaQuery.of(context).size.width - 21) / 2.5573
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/user_card_profile.png",
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.none,
                                width: (MediaQuery.of(context).size.width - 21) / 2.5573,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                height: 205,
                                child: Image.asset(
                                  p.p.getPfp,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      // User Data
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          width: (MediaQuery.of(context).size.width - 21) / 1.6421
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/user_card_details.png",
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.none,
                                width: (MediaQuery.of(context).size.width - 21) / 1.6421,
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Text(
                                      "Welcome ${p.p.getUsername}!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Currently you have ${p.p.getFavItems.length} items in your Ender Chest"),
                                    SizedBox(height: 10,),
                                    Text("Chest Grid Size: ${p.p.getGridSize}")
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),
              // Menu
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  height: 250,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    children: [
                      menuButton(context, "assets/chest.png", "Items", () {
                          Audio.chestOpen();
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Pantalla1()),
                        ).then((_) {
                          Audio.chestClose1();
                          setState(() => randomCommandBlock = getCommandBlock());
                        });
                        }
                      ),
                      menuButton(context, "assets/ender_chest.png", "Favorite Items", () {
                          Audio.enderChestOpen();
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyItemsPage()),
                        ).then((_) {
                          Audio.enderChestClose();
                          setState(() => randomCommandBlock = getCommandBlock());
                        });
                        }
                      ),
                      menuButton(context, randomCommandBlock, "Settings", () {
                          Audio.button();
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        ).then((_) {
                          setState(() => randomCommandBlock = getCommandBlock());
                        });
                        }
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

Widget menuButton(
  BuildContext context, 
  String imagePath, 
  String slotName,
  VoidCallback onPressed, 
) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Stack(
      children: [
        AppCustomWidget.menuItemSlot,
        Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            imagePath,
            filterQuality: FilterQuality.none,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Text(
            slotName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          ),
        ),
        InkWell(
          onTap: onPressed,
        )
      ],
    ),
  );
}
