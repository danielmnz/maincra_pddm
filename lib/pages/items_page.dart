import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maincra_api/core/audio_player.dart';
import 'package:maincra_api/core/widgets.dart';
import 'package:maincra_api/core/text_style.dart';
import 'package:maincra_api/entity/item.dart';
import 'package:maincra_api/core/image_decoration.dart';
import 'package:maincra_api/entity/profile.dart' as p;
import 'package:maincra_api/pages/view_item_page.dart';
import 'package:maincra_api/services/item_api.dart';

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  late List<Item> futureItem;
  late Future<List<Item>> searchFutureItems;

  late TextEditingController searchController;
  late ScrollController listController;

  String searchText = "";
  bool apiTimedOut = false;

  late int count = 0;

  Future<List<Item>> searchItems() async {
    futureItem = await fetchItems();
    List<Item> filteredItems = [];

    if (searchText.isNotEmpty) {
      for (int i = 0; i < futureItem.length; i++) {
        if (futureItem[i].name.contains(searchText)) {
          filteredItems.add(futureItem[i]);
        }
      }
      setState(() => count = filteredItems.length);
      return filteredItems;
    } else {
      setState(() => count = futureItem.length);
      return futureItem;
    }
  }

  Future<void> updateCount() async {
    futureItem = await fetchItems();
    setState(() => count = futureItem.length);
  }

  Future<void> checkTimedOut() async {
    apiTimedOut = true;
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    listController = ScrollController();

    searchFutureItems = fetchItems();
    updateCount();
    // listController.
  }

  @override
  void dispose() {
    listController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Items")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 150,
                          maxHeight: 75,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/textfield_bg_search.png"),
                            filterQuality: FilterQuality.none,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search Item", // lol
                              hintStyle: TextStyle(color: Colors.grey[700]),
                              border: InputBorder.none,
                            ),
                            onChanged:
                                (value) => setState(() {
                                   // Output: Hello World

                                  searchText = value;
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Image.asset(
                        "assets/search_button.png",
                        width: 65,
                        filterQuality: FilterQuality.none,
                        fit: BoxFit.cover,
                      ),
                      iconSize: 100,
                      onPressed: () {
                        String sentence = searchController.text;
                          List<String> words = sentence.split(" ");
                          String capitalizedSentence = words.map((word) => word.capitalize()).join(" ");
                          print(capitalizedSentence);
                        setState(() {
                          searchText = capitalizedSentence;
                          searchFutureItems = searchItems();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            FutureBuilder<List<Item>>(
              future: searchFutureItems,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        controller: listController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: p.p.getGridSize,
                        ),
                        itemCount: count,
                        itemBuilder: (context, index) {
                          if (count > 0) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return gridViewItem(
                                  context,
                                  snapshot.data![index].image,
                                  snapshot.data![index].name,
                                  snapshot.data![index].description,
                                  () {
                                    Audio.button();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewItemPage(item: snapshot.data![index].name),
                                      ),
                                    ).then((_) {});
                                  },
                                );
                              }
                            }
                          }
                        },
                      ),
                    ),
                  );
                } else {
                  return AppCustomWidget.loadingData;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget gridViewItem(
  BuildContext context,
  String image,
  String name,
  String description,
  VoidCallback? onPressed,
) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Stack(
      children: [
        AppCustomWidget.itemSlot,
        IconButton(
          icon: Image.network(
            image,
            width: double.maxFinite,
            height: double.maxFinite,
            filterQuality: FilterQuality.none,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    value:
                        loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) => Text("Could not load item Image", style: TextStyle(color: Colors.red),),
          ),
          onPressed: onPressed,
          onLongPress: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(description),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
