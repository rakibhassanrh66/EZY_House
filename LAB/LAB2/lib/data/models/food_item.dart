class FoodItem {
  final int id;
  final String name;
  final String restaurant;
  final double rating;
  final String imageUrl;
  final String description;
  final double price;
  final int spicyLevel; // 0‑5
  final String category;
  final String prepTime;

  const FoodItem({
    required this.id,
    required this.name,
    required this.restaurant,
    required this.rating,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.spicyLevel,
    required this.category,
    required this.prepTime,
  });
}
