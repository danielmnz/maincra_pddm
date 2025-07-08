
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maincra_api/entity/block.dart';

Future<Block> fetchBlock() async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/blocks"));
  
  if (response.statusCode == 200) {
    return Block.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load block.");
  }
}

Future<Block> fetchSingleBlock(String name) async {
  final response = await http.get(Uri.parse("https://minecraft-api.vercel.app/api/blocks?name=$name"));

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    if (json.isNotEmpty) {
      return Block(
        name: json[0]["name"], 
        nameSpaceId: json[0]["namespacedId"], 
        description: json[0]["description"], 
        image: json[0]["image"], 
        item: json[0]["item"], 
        tool: json[0]["tool"].toString(), 
        flammable: json[0]["flammable"], 
        transparent: json[0]["transparent"], 
        luminance: json[0]["luminance"], 
        blastResistance: double.parse(json[0]["blastResistance"].toString()), 
      );
    } else {
      return Block(name: 'NotPlaceable', nameSpaceId: 'nameSpaceId', description: 'description', image: 'image', item: 'item', tool: 'tool', flammable: true, transparent: true, luminance: 0, blastResistance: 0);
    }
  } else {
    throw Exception("Failted to get specified Block");
  }
}