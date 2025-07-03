import 'package:flutter/material.dart';
import 'package:maincra_api/entity/item.dart';
import 'package:maincra_api/services/item_api.dart';

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  late Future<Item> futureItem;

  late TextEditingController searchController;


  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    futureItem = fetchItem("Acacia Boat");
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
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: TextButton(
                child: const Text("Buscar item"),
                onPressed: () {
                  futureItem = fetchItem(searchController.text);
                }, 
              ),
            ),
          ),

          FutureBuilder<Item>(
            future: futureItem,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(snapshot.data!.image),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(snapshot.data!.name),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Card(child: Text("${snapshot.error}"));
              }
            },
          )
        ],
      ),
    );
  }
}