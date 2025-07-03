import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maincra_api/entity/item.dart';

Future<Item> fetchItem(String itemName) async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/items?name=$itemName"));

  if (response.statusCode == 200) {
    return Item.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load item.");
  }
}