import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maincra_api/entity/item.dart';

Future<List<Item>> fetchItems([String name = ""]) async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/items"));

  if (response.statusCode == 200) {
    
    dynamic json = jsonDecode(response.body);
    if (items.isEmpty) {
      for (int i = 0; i < json.length; i++) {
        // print(json[i]["name"]);
        items.add(
          Item(
            name: json[i]["name"],
            nameSpaceId: json[i]["namespacedId"],
            description: json[i]["description"],
            image: json[i]["image"],
            stackSize: json[i]["stackSize"],
            renewable: json[i]["renewable"],
          ),
        );
      }
      print("Items added");
    }

    print("Items returned");
    return items;
    // print(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load items.");
  }
}

Future<Item> fetchSingleItem(String name) async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/items?name=$name"));

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    return Item(
      name: json[0]["name"],
      nameSpaceId: json[0]["namespacedId"],
      description: json[0]["description"],
      image: json[0]["image"],
      stackSize: json[0]["stackSize"],
      renewable: json[0]["renewable"],
    );
  } else {
    throw Exception("Failed to get specified item.");
  }
}

Future<String> fetchItemImage(String name) async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/items?name=$name"));

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    return json[0]["image"];
  } else {
    throw Exception("Failed to get the specified item Image");
  }
}
