import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AnimatedFAB extends StatefulWidget {
  final VoidCallback onTap;
  const AnimatedFAB({super.key, required this.onTap});

  @override
  State<AnimatedFAB> createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<AnimatedFAB>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600));
    _bounce = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 28),
      TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 28),
      TweenSequenceItem(tween: Tween(begin: 0, end: -5), weight: 22),
      TweenSequenceItem(tween: Tween(begin: -5, end: 0), weight: 22),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _ctrl.repeat(period: const Duration(milliseconds: 2000));
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _bounce.value),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF3B3B), Color(0xFFE82828)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.45),
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.shopping_bag_outlined,
                color: Colors.white, size: 26),
          ),
        ),
      ),
    );
  }
}
