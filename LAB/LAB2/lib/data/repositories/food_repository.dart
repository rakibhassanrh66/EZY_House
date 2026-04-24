import '../models/food_item.dart';
import '../models/category_model.dart';

class FoodRepository {
  List<CategoryModel> getCategories() => const [
        CategoryModel(id: 'all', name: 'All', icon: '🍽️'),
        CategoryModel(id: 'burgers', name: 'Burgers', icon: '🍔'),
        CategoryModel(id: 'pizza', name: 'Pizza', icon: '🍕'),
        CategoryModel(id: 'sushi', name: 'Sushi', icon: '🍣'),
        CategoryModel(id: 'salads', name: 'Salads', icon: '🥗'),
        CategoryModel(id: 'pasta', name: 'Pasta', icon: '🍝'),
      ];

  List<FoodItem> getFoodItems() => const [
        FoodItem(
          id: 1,
          name: 'Classic Cheeseburger',
          restaurant: 'Burger Palace',
          rating: 4.8,
          imageUrl:
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&h=400&fit=crop',
          description:
              'Juicy beef patty with melted cheddar, crisp lettuce, fresh tomatoes, pickles, and our signature sauce on a toasted brioche bun.',
          price: 12.99,
          spicyLevel: 1,
          category: 'burgers',
          prepTime: '15 min',
        ),
        FoodItem(
          id: 2,
          name: 'Margherita Pizza',
          restaurant: 'Napoli Express',
          rating: 4.7,
          imageUrl:
              'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600&h=400&fit=crop',
          description:
              'Traditional Neapolitan pizza with San Marzano tomatoes, fresh mozzarella di bufala, basil leaves, and extra virgin olive oil.',
          price: 14.99,
          spicyLevel: 0,
          category: 'pizza',
          prepTime: '20 min',
        ),
        FoodItem(
          id: 3,
          name: 'Salmon Sushi Roll',
          restaurant: 'Tokyo Garden',
          rating: 4.9,
          imageUrl:
              'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=600&h=400&fit=crop',
          description:
              'Fresh Atlantic salmon, avocado, cucumber, and sesame seeds wrapped in premium sushi rice and nori.',
          price: 16.99,
          spicyLevel: 2,
          category: 'sushi',
          prepTime: '25 min',
        ),
        FoodItem(
          id: 4,
          name: 'Caesar Salad',
          restaurant: 'Green Garden',
          rating: 4.5,
          imageUrl:
              'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=600&h=400&fit=crop',
          description:
              'Crisp romaine lettuce, parmesan, croutons, cherry tomatoes, and grilled chicken tossed in creamy Caesar dressing.',
          price: 10.99,
          spicyLevel: 0,
          category: 'salads',
          prepTime: '10 min',
        ),
        FoodItem(
          id: 5,
          name: 'Creamy Carbonara',
          restaurant: 'Pasta Roma',
          rating: 4.6,
          imageUrl:
              'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=600&h=400&fit=crop',
          description:
              'Al dente spaghetti with crispy pancetta, egg yolk, pecorino Romano, black pepper, and a touch of cream.',
          price: 13.99,
          spicyLevel: 1,
          category: 'pasta',
          prepTime: '18 min',
        ),
        FoodItem(
          id: 6,
          name: 'BBQ Bacon Burger',
          restaurant: 'Burger Palace',
          rating: 4.8,
          imageUrl:
              'https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=600&h=400&fit=crop',
          description:
              'Double-smashed patties with smoky BBQ sauce, crispy bacon, cheddar, caramelized onions, and coleslaw.',
          price: 15.99,
          spicyLevel: 2,
          category: 'burgers',
          prepTime: '18 min',
        ),
        FoodItem(
          id: 7,
          name: 'Spicy Tuna Roll',
          restaurant: 'Tokyo Garden',
          rating: 4.7,
          imageUrl:
              'https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56?w=600&h=400&fit=crop',
          description:
              'Fresh ahi tuna, spicy mayo, cucumber, and tempura flakes topped with sriracha and eel sauce.',
          price: 14.99,
          spicyLevel: 4,
          category: 'sushi',
          prepTime: '22 min',
        ),
        FoodItem(
          id: 8,
          name: 'Pepperoni Supreme',
          restaurant: 'Napoli Express',
          rating: 4.6,
          imageUrl:
              'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=600&h=400&fit=crop',
          description:
              'Loaded pepperoni pizza with double cheese, olives, bell peppers, mushrooms, and a drizzle of hot honey.',
          price: 16.99,
          spicyLevel: 3,
          category: 'pizza',
          prepTime: '20 min',
        ),
      ];
}
