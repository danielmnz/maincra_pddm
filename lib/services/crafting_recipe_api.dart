import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maincra_api/entity/crafting_recipe.dart';

Future<List<CraftingRecipe>> fetchCraftingRecipe(String item) async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/crafting-recipes"));

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);

    if (craftingRecipes.isEmpty) {
      for (int i = 0; i < json.length; i++) {
        craftingRecipes.add(
          CraftingRecipe(
            item: json[i]["item"], 
            quantity: json[i]["quantity"], 
            shapeless: json[i]["shapeless"], 
            recipe: json[i]["recipe"]
          )
        );
      }
      print("Crafting Recipes added");
    }

    print("Crafting Recipes Returned");
    return craftingRecipes;

  } else {
    throw Exception("Failed to load Crafting Recipe.");
  }
}

Future<CraftingRecipe> fetchSingleCraftingRecipe(String name) async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/crafting-recipes?item=$name"));

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    print(json);
    if (json.isNotEmpty) {
      return CraftingRecipe(
        item: json[0]["item"], 
        quantity: json[0]["quantity"], 
        shapeless: json[0]["shapeless"], 
        recipe: json[0]["recipe"]
      );
    } else {
      return CraftingRecipe(item: 'item', quantity: 0, shapeless: true, recipe: []);
    }
  } else {
    throw Exception("Failed to get specified Crafting Recipe");
  }
}

