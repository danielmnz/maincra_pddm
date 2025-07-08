import 'package:flutter/material.dart';
import 'package:maincra_api/core/widgets.dart';
import 'package:maincra_api/pages/items_page.dart';
import 'package:maincra_api/pages/my_items_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome!"),),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            children: [
              menuButton(context, "assets/chest.png", Pantalla1()),
              menuButton(context, "assets/ender_chest.png", MyItemsPage()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget menuButton(BuildContext context, String imagePath, Widget page) {
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
          onPressed: () => Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => page)
          ), 
        )
      ],
    ),
  );
}