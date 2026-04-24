import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../data/providers/providers.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_chips.dart';
import '../widgets/food_card.dart';
import '../widgets/animated_fab.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final foods = ref.watch(filteredFoodItemsProvider);
    final favCount = ref.watch(favoritesProvider).length;
    final mq = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── Header ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        AppConstants.padding, 16, AppConstants.padding, 0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Foodgo',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accent,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Find the best food for you',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Avatar
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(Icons.person,
                                color: Colors.white, size: 26),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // ── Search ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.padding),
                    child: const SearchBarWidget(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // ── Categories ──
                SliverToBoxAdapter(
                  child: CategoryChips(categories: categories),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // ── Section title ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _navIndex == 1 ? 'Favorites' : 'Popular Items',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${_navIndex == 1 ? ref.watch(favoriteFoodItemsProvider).length : foods.length} items',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // ── Grid ──
                if (_navIndex == 1)
                  _buildFavGrid(ref)
                else
                  _buildFoodGrid(foods),

                // Bottom padding for nav + FAB
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          ),

          // ── Centre FAB ──
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedFAB(onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Cart opened!'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    backgroundColor: AppColors.accent,
                    duration: const Duration(seconds: 1),
                  ),
                );
              }),
            ),
          ),

          // ── Bottom nav ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(
              currentIndex: _navIndex,
              onTap: (i) => setState(() => _navIndex = i),
              favCount: favCount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodGrid(List foods) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => FoodCard(food: foods[i], index: i),
          childCount: foods.length,
        ),
      ),
    );
  }

  Widget _buildFavGrid(WidgetRef ref) {
    final favs = ref.watch(favoriteFoodItemsProvider);
    if (favs.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 120),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_border,
                    size: 64, color: AppColors.textSecondary),
                SizedBox(height: 12),
                Text('No favorites yet',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 16)),
              ],
            ),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => FoodCard(food: favs[i], index: i),
          childCount: favs.length,
        ),
      ),
    );
  }
}
