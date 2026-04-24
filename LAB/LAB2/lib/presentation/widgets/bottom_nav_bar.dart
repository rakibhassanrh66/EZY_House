import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int favCount;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.favCount = 0,
  });

  static const _icons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.shopping_bag_rounded,
    Icons.person_rounded,
  ];
  static const _labels = ['Home', 'Favorites', 'Cart', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      height: 76 + mq.padding.bottom,
      padding: EdgeInsets.only(bottom: mq.padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (i) {
          final active = i == currentIndex;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(i),
            child: SizedBox(
              width: 64,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Icon pill ──
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.primary.withOpacity(0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          _icons[i],
                          size: 24,
                          color: active
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        // ── Badge on Favorites tab ──
                        if (i == 1 && favCount > 0)
                          Positioned(
                            top: -6,
                            right: -10,
                            child: AnimatedScale(
                              scale: favCount > 0 ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.elasticOut,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$favCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                  // ── Label ──
                  Text(
                    _labels[i],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      color:
                          active ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
