import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maincra_api/core/widgets.dart';
import 'package:maincra_api/core/text_style.dart';
import 'package:maincra_api/entity/item.dart';
import 'package:maincra_api/core/image_decoration.dart';
import 'package:maincra_api/pages/view_item_page.dart';
import 'package:maincra_api/services/item_api.dart';

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  late Future<List<Item>> futureItem;

  late TextEditingController searchController;
  late ScrollController listController;

  int count = 30;

  void loadMoreItems() {
    if (listController.offset >= listController.position.maxScrollExtent) {
      setState(() => count += 30);
    }
  }


  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    listController = ScrollController();
    futureItem = fetchItems();

    listController.addListener(loadMoreItems);

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
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Buscar un item", // lol
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  //print("el texto es $text");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextButton(
                  child: const Text("Buscar item"),
                  onPressed: () {
                    /*setState(() {
                      //futureItem = fetchItems(searchController.text);
                      //print("el texto es $futureItem");
                    });*/
                    //lo intenté pero no me mostraba el item sino la instancia de la lista (probar debug)
                  },
                ),
              ),
            ),
        
            FutureBuilder<List<Item>>(
              future: futureItem,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        controller: listController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        // itemCount: snapshot.data!.length,
                        itemCount: count,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            children: [
                              AppCustomWidget.itemSlot,
                              IconButton(
                                icon: Image.network(snapshot.data![index].image,
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
                                          color: Colors.black,
                                          value: loadingProgress.expectedTotalBytes != null 
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! 
                                            : null,
                                        )
                                      );
                                    }
                                  },
                                ),
                                onPressed: () => Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => ViewItemPage(item: snapshot.data![index].name)
                                  )
                                ),
                                onLongPress: () => showDialog(
                                  context: context, 
                                  builder: (context) => AlertDialog(
                                    title: Text(snapshot.data![index].name, 
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(snapshot.data![index].description),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      TextButton(
                                        child: Text("Close"),
                                        onPressed: () => Navigator.pop(context), 
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
