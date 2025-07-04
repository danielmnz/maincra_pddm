library;

List<Item> items = [];

bool doneLoading = false;

void finishLoading() => doneLoading = true;

Future<bool> checkIfEmpty() async {
  if (doneLoading) {
    return true;
  } else {
    return false;
  }
}

class Item {
  final String name;
  final String nameSpaceId;
  final String description;
  final String image;
  final int stackSize;
  final bool renewable;

  const Item({
    required this.name,
    required this.nameSpaceId,
    required this.description,
    required this.image,
    required this.stackSize,
    required this.renewable,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'nameSpaceId': String nameSpaceId,
        'description': String description,
        'image': String image,
        'stackSize': int stackSize,
        'renewable': bool renewable,
      } =>
        Item(
          name: name,
          nameSpaceId: nameSpaceId,
          description: description,
          image: image,
          stackSize: stackSize,
          renewable: renewable,
        ),
      _ => throw const FormatException('Failed to load item.'),
    };
  }
}
