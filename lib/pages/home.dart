import 'package:flutter/material.dart';
import 'package:maincra_api/entity/item.dart';
import 'package:maincra_api/core/image_decoration.dart';

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  late Future<bool> futureItem;

  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    futureItem = checkIfEmpty();
    // futureItem = fetchItem("Acacia Boat");
    // print(futureItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white, //color objetos appbar
        title: Text("Maincra App :)"),
      ),

      backgroundColor: Colors.brown,

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Buscar Item lol xd omg en plan holy shit", // lol
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextButton(
                child: const Text("Buscar item"),
                onPressed: () {
                  // futureItem = fetchItem(searchController.text);
                },
              ),
            ),
          ),

          FutureBuilder(
            future: futureItem,
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.hasData) {
                return Card(
                  child: Column(
                    children: [
                      // Text("${items.length}")
                      Image.network(items[1].image),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: ImageDecoration.fit,
                          child: Text(items[1].name,
                          )),
                      ),
                    ],
                  ),
                );
              } else {
                return Card(
                  child: Text(
                    "${snapshot.error}",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
