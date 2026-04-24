import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/food_item.dart';
import '../../data/providers/providers.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final FoodItem food;
  const ProductDetailsScreen({super.key, required this.food});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;
  bool _orderPressed = false;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    final portion = ref.watch(portionProvider(food.id));
    final spice = ref.watch(spiceLevelProvider(food.id));
    final favorites = ref.watch(favoritesProvider);
    final isFav = favorites.contains(food.id);
    final mq = MediaQuery.of(context);
    final totalPrice = food.price * portion;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Scrollable body ──
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Hero image ──
              SliverAppBar(
                expandedHeight: mq.size.height * 0.4,
                pinned: true,
                backgroundColor: Colors.transparent,
                leading: const SizedBox.shrink(),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'food_image_${food.id}',
                        child: Image.network(
                          food.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.55),
                            ],
                          ),
                        ),
                      ),
                      // rating badge
                      Positioned(
                        bottom: 16,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star,
                                  color: AppColors.starYellow, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                formatRating(food.rating),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                  width: 1,
                                  height: 16,
                                  color:
                                      AppColors.textSecondary.withOpacity(0.3)),
                              const SizedBox(width: 6),
                              const Icon(Icons.access_time,
                                  size: 16, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(food.prepTime,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Details ──
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  food.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => toggleFavorite(ref, food.id),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: isFav
                                        ? AppColors.lightRed
                                        : AppColors.background,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.06),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (c, a) =>
                                        ScaleTransition(
                                      scale: CurvedAnimation(
                                          parent: a, curve: Curves.elasticOut),
                                      child: c,
                                    ),
                                    child: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      key: ValueKey(isFav),
                                      color: isFav
                                          ? AppColors.primary
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            food.restaurant,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 18),

                          // ── Description ──
                          const Text(
                            'About this dish',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            food.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              height: 1.55,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // ── Spicy slider ──
                          _buildSpicySection(food, spice),
                          const SizedBox(height: 28),

                          // ── Portion selector ──
                          _buildPortionSection(portion, food),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Back button ──
          Positioned(
            top: mq.padding.top + 10,
            left: 16,
            child: _circleButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.pop(context),
            ),
          ),

          // ── Bottom bar ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 16, 20, mq.padding.bottom + 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Price badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.lightRed,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Total Price',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textSecondary)),
                        const SizedBox(height: 2),
                        Text(
                          formatPrice(totalPrice),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Order button
                  Expanded(
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _orderPressed = true),
                      onTapUp: (_) => _placeOrder(food, portion),
                      onTapCancel: () => setState(() => _orderPressed = false),
                      child: AnimatedScale(
                        scale: _orderPressed ? 0.95 : 1.0,
                        duration: const Duration(milliseconds: 120),
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF3B3B),
                                Color(0xFFE82828),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'ORDER NOW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Spicy slider ──────────────────────────────────────────────
  Widget _buildSpicySection(FoodItem food, int spice) {
    final labels = [
      'None',
      'Mild',
      'Medium',
      'Spicy',
      '🔥 Extra',
      '💀 Extreme'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Spice Level',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.lightRed,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                labels[spice.clamp(0, 5)],
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.lightRed,
            thumbColor: AppColors.primary,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: AppColors.primary.withOpacity(0.15),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            trackHeight: 6,
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: spice.toDouble(),
            min: 0,
            max: 5,
            divisions: 5,
            onChanged: (v) {
              ref.read(spiceLevelProvider(food.id).notifier).state = v.round();
            },
          ),
        ),
      ],
    );
  }

  // ── Portion selector ──────────────────────────────────────────
  Widget _buildPortionSection(int portion, FoodItem food) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Portions',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Row(
          children: [
            _portionButton(
              icon: Icons.remove,
              onTap: () {
                if (portion > 1) {
                  ref.read(portionProvider(food.id).notifier).state--;
                }
              },
            ),
            const SizedBox(width: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
              child: Text(
                '$portion',
                key: ValueKey(portion),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 20),
            _portionButton(
              icon: Icons.add,
              onTap: () {
                if (portion < 10) {
                  ref.read(portionProvider(food.id).notifier).state++;
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _portionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }

  void _placeOrder(FoodItem food, int portion) {
    setState(() => _orderPressed = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${food.name} × $portion added to cart!',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: AppColors.accent,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: AppColors.primary,
          onPressed: () {},
        ),
      ),
    );
  }
}
