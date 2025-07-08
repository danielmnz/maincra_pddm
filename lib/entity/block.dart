



class Block {
  final String name;
  final String nameSpaceId;
  final String description;
  final String image;
  final String item;
  final String tool;
  final bool flammable;
  final bool transparent;
  final int luminance;
  final double blastResistance;

  const Block({
    required this.name,
    required this.nameSpaceId,
    required this.description,
    required this.image,
    required this.item,
    required this.tool,
    required this.flammable,
    required this.transparent,
    required this.luminance,
    required this.blastResistance
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "name": String name,
        "nameSpaceId": String nameSpaceId,
        "description": String description,
        "image": String image,
        "item": String item,
        "tool": String tool,
        "flammable": bool flammable,
        "transparent": bool transparent,
        "luminance": int luminance,
        "blastResistance": double blastResistance
      } => Block(name: name, nameSpaceId: nameSpaceId, description: description, image: image, item: item, tool: tool, flammable: flammable, transparent: transparent, luminance: luminance, blastResistance: blastResistance),
      _ => throw const FormatException("Failed to load block."),
    };
  }
}