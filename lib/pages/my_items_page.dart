import 'package:flutter/material.dart';
import 'package:maincra_api/core/audio_player.dart';
import 'package:maincra_api/entity/item.dart';
import 'package:maincra_api/entity/profile.dart' as p;
import 'package:maincra_api/pages/items_page.dart';
import 'package:maincra_api/pages/view_item_page.dart';

class MyItemsPage extends StatefulWidget {
  const MyItemsPage({super.key});

  @override
  State<MyItemsPage> createState() => _MyItemsPageState();
}

class _MyItemsPageState extends State<MyItemsPage> {
  List<Item> myFavItems = p.p.getFavItems;

  void updateItems() async {
    setState(() {
      myFavItems = p.p.getFavItems;
    });
    print("Reloaded Page");
  }

  @override
  void initState() {
    print(p.p.getFavItems.isEmpty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, color: Colors.white),
            SizedBox(width: 8),
            Text("My Items"),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        child: Container(
          child: p.p.getFavItems.isNotEmpty
          ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: p.p.getGridSize,
            ),
            // itemCount: p.p.getFavItems.isEmpty ? 1 : p.p.getFavItems.length,
            itemCount: myFavItems.length,
            itemBuilder: (context, index) {
              return gridViewItem(
                context,
                myFavItems[index].image,
                myFavItems[index].name,
                myFavItems[index].description,
                () {
                  Audio.button();
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewItemPage(item: myFavItems[index].name),
                  ),
                ).then((_) {
                  updateItems();
                });
                },
              );
            },
          )
          : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/item_not_found.png",
                  width: 100,
                  filterQuality: FilterQuality.none,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  "There's not Favorite Items yet",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 30),
                Text(
                  "Try adding some from the Chest!",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
