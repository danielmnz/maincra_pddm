import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maincra_api/entity/item.dart';

Future<bool> fetchItems() async {
  final response = await http.get(
    Uri.parse("https://minecraft-api.vercel.app/api/items"),
  );

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    print(json[0]["name"]);
    print(json[0]["namespacedId"]);
    print(json[0]["description"]);
    print(json[0]["image"]);
    print((json[0]["stackSize"]));
    print((json[0]["renewable"]));

    for (int i = 0; i < json.length; i++) {
      print(json[i]["name"]);
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

    finishLoading();

    return checkIfEmpty();
    // print(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load item.");
  }
}
