
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