import 'package:flutter/material.dart';
import 'package:maincra_api/core/widgets.dart';
import 'package:maincra_api/entity/block.dart';
import 'package:maincra_api/entity/crafting_recipe.dart';
import 'package:maincra_api/entity/item.dart';
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

  Future<List<dynamic>> getCraftingItems() async {
    CraftingRecipe craftingRecipe = await fetchSingleCraftingRecipe(widget.item);
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


  @override
  void initState() {
    futureItem = fetchSingleItem(widget.item);
    futureBlock = fetchSingleBlock(widget.item);
    futureCrafting = fetchSingleCraftingRecipe(widget.item);
    futureCraftingItems = getCraftingItems();
    getCraftingItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<Item>(
            future: futureItem,
            builder: (context, snapshotItem) {
              if (snapshotItem.hasData) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: SizedBox(
                        width: 200, height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppCustomWidget.itemSlot,
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: SizedBox(
                                height: 200, width: 200,
                                child: Image.network(
                                  snapshotItem.data!.image,
                                  filterQuality: FilterQuality.none,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(snapshotItem.data!.description),
                    Text(snapshotItem.data!.renewable ? "Renewable: Yes" : "Renewable: No"),
                    Text("Stack Size: ${snapshotItem.data!.stackSize}"),

                    SizedBox(height: 20,),
                    
                    FutureBuilder<Block>(
                      future: futureBlock, 
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.name != "NotPlaceable") {
                            return Container(
                              child: Column(
                                children: [
                                  Text(snapshot.data!.tool == "null" ? "Does not have Best Tool" : "Best Tool: ${snapshot.data!.tool}"),
                                  Text(snapshot.data!.flammable ? "Flammable: Yes" : "Flammable: No"),
                                  Text(snapshot.data!.transparent ? "Transparent: Yes" : "Transparent: No"),
                                  Text("Luminance: ${snapshot.data!.luminance}"),
                                  Text("Blast Resistance: ${snapshot.data!.blastResistance}"),
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

                    SizedBox(height: 20,),

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
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                                    itemCount: 9,
                                    itemBuilder: (context, index) => Padding(
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
                                                    child: Image.network(snapshotRecipe.data![index],
                                                      filterQuality: FilterQuality.none,
                                                      width: double.maxFinite,
                                                      height: double.maxFinite,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  );
                                                }
                                              } else {
                                                return Center(child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: AppCustomWidget.loadingImage,
                                                ));
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text("Quantity Crafted: ${snapshotCrafting.data!.quantity}"),
                                Text(snapshotCrafting.data!.shapeless ? "Shapeless Crafting" : "Strict Crafting")
                              ],
                            );
                          } else {
                            return Text("Item does not have Crafting Recipe");
                          }
                        } else {
                          return Text("Item does not have Crafting Recipe");
                        }
                      },
                    )

                  ],
                );
              } else {
                return AppCustomWidget.loadingData;
              }
            },
          )
        ),
      ),
    );
  }
}