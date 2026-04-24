import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/food_item.dart';
import '../models/category_model.dart';
import '../repositories/food_repository.dart';

// ── Repository ──────────────────────────────────────────────────
final foodRepositoryProvider =
    Provider<FoodRepository>((_) => FoodRepository());

// ── Data ────────────────────────────────────────────────────────
final categoriesProvider = Provider<List<CategoryModel>>(
  (ref) => ref.read(foodRepositoryProvider).getCategories(),
);
final foodItemsProvider = Provider<List<FoodItem>>(
  (ref) => ref.read(foodRepositoryProvider).getFoodItems(),
);

// ── Filters ─────────────────────────────────────────────────────
final selectedCategoryProvider = StateProvider<String>((_) => 'all');
final searchQueryProvider = StateProvider<String>((_) => '');

// ── Derived: filtered food list ──────────────────────────────────
final filteredFoodItemsProvider = Provider<List<FoodItem>>((ref) {
  final items = ref.watch(foodItemsProvider);
  final cat = ref.watch(selectedCategoryProvider);
  final q = ref.watch(searchQueryProvider).toLowerCase().trim();

  List<FoodItem> result = items;
  if (cat != 'all') {
    result = result.where((f) => f.category == cat).toList();
  }
  if (q.isNotEmpty) {
    result = result
        .where((f) =>
            f.name.toLowerCase().contains(q) ||
            f.restaurant.toLowerCase().contains(q) ||
            f.category.toLowerCase().contains(q))
        .toList();
  }
  return result;
});

// ── Favorites ───────────────────────────────────────────────────
final favoritesProvider = StateProvider<Set<int>>((_) => {});

final favoriteFoodItemsProvider = Provider<List<FoodItem>>((ref) {
  final items = ref.watch(foodItemsProvider);
  final ids = ref.watch(favoritesProvider);
  return items.where((i) => ids.contains(i.id)).toList();
});

void toggleFavorite(WidgetRef ref, int id) {
  ref.read(favoritesProvider.notifier).update((s) {
    final next = Set<int>.from(s);
    next.contains(id) ? next.remove(id) : next.add(id);
    return next;
  });
}

// ── Per‑item portion & spice ────────────────────────────────────
final portionProvider = StateProvider.family<int, int>((_, __) => 1);

final spiceLevelProvider = StateProvider.family<int, int>((ref, foodId) {
  final items = ref.read(foodItemsProvider);
  return items.firstWhere((f) => f.id == foodId).spicyLevel;
});
