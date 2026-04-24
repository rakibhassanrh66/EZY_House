import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/theme/app_theme.dart';
import 'package:task/presentation/providers/result_provider.dart';
import 'package:task/presentation/screens/home_screen.dart';
import 'package:task/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResultProvider(),
      child: MaterialApp(
        title: 'EduResult Pro',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // Auto follows system light/dark
        home: const AppRouter(),
      ),
    );
  }
}

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  bool _showHome = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.easeInOutCubic,
      switchOutCurve: Curves.easeInOutCubic,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.2),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: _showHome
          ? const HomeScreen(key: ValueKey('home'))
          : SplashScreen(
              key: const ValueKey('splash'),
              onComplete: () => setState(() => _showHome = true),
            ),
    );
  }
}
