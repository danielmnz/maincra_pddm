import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maincra_api/core/audio_player.dart';
import 'package:maincra_api/core/text_style.dart';
import 'package:maincra_api/core/widgets.dart';
import 'package:maincra_api/entity/block.dart';
import 'package:maincra_api/entity/crafting_recipe.dart';
import 'package:maincra_api/entity/item.dart';
import 'package:maincra_api/entity/profile.dart' as p;
import 'package:maincra_api/services/block_api.dart';
import 'package:maincra_api/services/crafting_recipe_api.dart';
import 'package:maincra_api/services/item_api.dart';

class ViewItemPage extends StatefulWidget {
  const ViewItemPage({super.key, required this.item});

  final String item;

  @override
  State<ViewItemPage> createState() => _ViewItemPageState();
}

class _ViewItemPageState extends State<ViewItemPage> {
  late Future<Item> futureItem;
  late Future<Block> futureBlock;
  late Future<CraftingRecipe> futureCrafting;
  late Future<List<dynamic>> futureCraftingItems;

  bool itemInFav = false;
  bool itemLoaded = false;
  bool canPop = true;
  String favIcon = "assets/no_fav_item.png";

  Future<List<dynamic>> getCraftingItems() async {
    CraftingRecipe craftingRecipe = await fetchSingleCraftingRecipe(
      widget.item,
    );
    List<dynamic> craftingItems = [];
    for (int i = 0; i < craftingRecipe.recipe.length; i++) {
      if (craftingRecipe.recipe[i] == null) {
        craftingItems.add(null);
      } else {
        craftingItems.add(await fetchItemImage(craftingRecipe.recipe[i]));
      }
    }
    return craftingItems;
  }

  void checkIfItemIsFav() {
    for (int i = 0; i < p.p.getFavItems.length; i++) {
      if (p.p.favItems[i].name == widget.item) {
        setState(() {
          itemInFav = true;
          favIcon = changeFavIcon(1);
        });
        print("Item Found");
        return;
      }
    }
  }

  void changeFavState() async {
    setState(() {
      canPop = false;
      favIcon = changeFavIcon(3);
    });

    Map<String, dynamic> jsonData = await p.p.readJson();

    if (itemInFav) {
      for (int i = 0; i < p.p.getFavItems.length; i++) {
        if (p.p.getFavItems[i].name == widget.item) {
          jsonData["favItems"].removeAt(i);
          p.p.getFavItems.removeAt(i);
        }
      }

      await p.p.saveJson(jsonData);

      setState(() {
        canPop = true;
        itemInFav = false;
        favIcon = changeFavIcon(2);
      });

      itemChangesNotif("Notice", "Item removed from your Ender Chest");
      print("Item Removed");
    } 
    else {
      Item favItem = await fetchSingleItem(widget.item);
      p.p.getFavItems.add(favItem);

      Map<String, dynamic> toJson() => {
        'name': favItem.name,
        'nameSpaceId': favItem.nameSpaceId,
        'description': favItem.description,
        'image': favItem.image,
        'stackSize': favItem.stackSize,
        'renewable': favItem.renewable,
      };

      var json = toJson();

      jsonData["favItems"].add(json);

      await p.p.saveJson(jsonData);

      setState(() {
        canPop = true;
        itemInFav = true;
        favIcon = changeFavIcon(1);
      });

      itemChangesNotif("Notice", "Item added to your Ender Chest");
      print("Item Added");
    }
  }

  void itemChangesNotif(String title, String content) {
    showDialog(
      barrierColor: Colors.black87,
      barrierDismissible: false,
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.setWhiteColor,
        ),
        content: Text(
          content,
          style: TextStyles.setWhiteColor,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Container(
            decoration: BoxDecoration(
              image: AppCustomWidget.containerSmallButton
            ),
            child: TextButton(
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              onPressed: () {
                Audio.button();
                Navigator.pop(context);
              }, 
            ),
          )
        ],
      ),
    );
  }

  String changeFavIcon(int i) {
    switch (i) {
      case 1: return "assets/fav_item.png";
      case 2: return "assets/no_fav_item.png";
      case 3: return "assets/fav_item_loading.png";
    }
    return "assets/no_fav_item.png";
  }

  @override
  void initState() {
    futureItem = fetchSingleItem(widget.item);
    futureBlock = fetchSingleBlock(widget.item);
    futureCrafting = fetchSingleCraftingRecipe(widget.item);
    futureCraftingItems = getCraftingItems();
    print(itemLoaded);

    futureItem.whenComplete(() => setState(() {
      itemLoaded = true;
      print(itemLoaded);
    }),);

    getCraftingItems();
    checkIfItemIsFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.item,
            // textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder<Item>(
              future: futureItem,
              builder: (context, snapshotItem) {
                if (snapshotItem.hasData) {
                  // updateItemLoaded(snapshotItem.hasData);
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AppCustomWidget.itemSlot,
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.network(
                                    snapshotItem.data!.image,
                                    filterQuality: FilterQuality.none,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(snapshotItem.data!.description),
                      Text(
                        snapshotItem.data!.renewable
                            ? "Renewable: Yes"
                            : "Renewable: No",
                      ),
                      Text("Stack Size: ${snapshotItem.data!.stackSize}"),
      
                      SizedBox(height: 20),
      
                      FutureBuilder<Block>(
                        future: futureBlock,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.name != "NotPlaceable") {
                              return Container(
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!.tool == "null"
                                          ? "Does not have Best Tool"
                                          : "Best Tool: ${snapshot.data!.tool}",
                                    ),
                                    Text(
                                      snapshot.data!.flammable
                                          ? "Flammable: Yes"
                                          : "Flammable: No",
                                    ),
                                    Text(
                                      snapshot.data!.transparent
                                          ? "Transparent: Yes"
                                          : "Transparent: No",
                                    ),
                                    Text(
                                      "Luminance: ${snapshot.data!.luminance}",
                                    ),
                                    Text(
                                      "Blast Resistance: ${snapshot.data!.blastResistance}",
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Text("Item cannot be placed.");
                            }
                          } else {
                            return Text("Item cannot be placed.");
                          }
                        },
                      ),
      
                      SizedBox(height: 20),
      
                      Text("Crafting Recipe"),
                      FutureBuilder<CraftingRecipe>(
                        future: futureCrafting,
                        builder: (context, snapshotCrafting) {
                          if (snapshotCrafting.hasData) {
                            if (snapshotCrafting.data!.recipe.isNotEmpty) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: 250,
                                    height: 250,
                                    child: GridView.builder(
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                          ),
                                      itemCount: 9,
                                      itemBuilder:
                                          (context, index) => Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Stack(
                                              children: [
                                                AppCustomWidget.itemSlot,
                                                FutureBuilder<List<dynamic>>(
                                                  future: futureCraftingItems,
                                                  builder: (context, snapshotRecipe) {
                                                    if (snapshotRecipe.hasData) {
                                                      if (snapshotRecipe.data![index] == null) {
                                                        return Container();
                                                      } else {
                                                        return Padding(
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Image.network(
                                                            snapshotRecipe.data![index],
                                                            filterQuality: FilterQuality.none,
                                                            width: double.maxFinite, 
                                                            height: double.maxFinite,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      return Center(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: AppCustomWidget.loadingImage,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                    ),
                                  ),
                                  Text(
                                    "Quantity Crafted: ${snapshotCrafting.data!.quantity}",
                                  ),
                                  Text(
                                    snapshotCrafting.data!.shapeless
                                        ? "Shapeless Crafting"
                                        : "Strict Crafting",
                                  ),
                                ],
                              );
                            } else {
                              return Text("Item does not have Crafting Recipe");
                            }
                          } else {
                            return Text("Item does not have Crafting Recipe");
                          }
                        },
                      ),
                    ],
                  );
                } else {
                  return AppCustomWidget.loadingData;
                }
              },
            ),
          ),
        ),
        floatingActionButton: itemLoaded ? FloatingActionButton.large(
          backgroundColor: Colors.transparent,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
          hoverColor: Colors.transparent,
          hoverElevation: 0,
          elevation: 0,
          child: Image.asset(favIcon,
            width: double.maxFinite,
            filterQuality: FilterQuality.none,
            fit: BoxFit.cover,
          ),
          onPressed: () => changeFavState(),
        )
        : Container()
      ),
    );
  }
}
