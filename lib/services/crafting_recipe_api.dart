import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maincra_api/entity/crafting_recipe.dart';

Future<CraftingRecipe> fetchCraftingRecipe() async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/crafting-recipes"));

  if (response.statusCode == 200) {
    return CraftingRecipe.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load Crafting Recipe.");
  }
}