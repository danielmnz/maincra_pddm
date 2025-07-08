library;

List<CraftingRecipe> craftingRecipes = [];

class CraftingRecipe {
  final String item;
  final int quantity;
  final bool shapeless;
  final List<dynamic> recipe;

  const CraftingRecipe({
    required this.item,
    required this.quantity,
    required this.shapeless,
    required this.recipe
  });

  factory CraftingRecipe.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "item": String item,
        "quantity": int quantity,
        "shapeless": bool shapeless,
        "recipe": List<dynamic> recipe,
      } => CraftingRecipe(item: item, quantity: quantity, shapeless: shapeless, recipe: recipe),
      _ => throw const FormatException("Failed to load Crafting Recipe.")
    };
  }
}