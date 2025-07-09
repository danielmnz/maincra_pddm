import 'package:flutter/material.dart';
import 'package:maincra_api/core/widgets.dart';
import 'package:maincra_api/pages/items_page.dart';
import 'package:maincra_api/pages/my_items_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/grass_block.png', height: 60),
            SizedBox(width: 8),
            Text("MaincraApp"),
          ],
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Image.asset("assets/item-bg.png"),
                  Text("data")
                ]
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 250,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  children: [
                    menuButton(context, "assets/chest.png", Pantalla1(), "Items"),
                    menuButton(context, "assets/ender_chest.png", MyItemsPage(), "Favorite Items"),
                    menuButton(context, "assets/furnace.png", Home(), "Settings")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget menuButton(BuildContext context, String imagePath, Widget page, String slotName) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Stack(
      children: [
        AppCustomWidget.itemSlot,
        IconButton(
          icon: Image.asset(
            imagePath,
            filterQuality: FilterQuality.none,
            fit: BoxFit.cover,
          ),
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
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
      ],
    ),
  );
}
