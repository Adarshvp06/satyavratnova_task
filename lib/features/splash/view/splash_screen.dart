import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../route/app_route.dart';
import '../../../gen/assets.gen.dart';
import '../../navigation/view/navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String path = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        navigate(context, NavigationScreen.path, replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Assets.png.splashscreenImage
            .image(height: 150.w, fit: BoxFit.cover)
            .animate()
            .fadeIn(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutQuad,
            )
            .blurXY(
              begin: 10,
              end: 0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
            )
            .scaleXY(
              begin: 0.85,
              end: 1,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutBack,
            )
            .moveY(
              begin: 30,
              end: 0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutQuad,
            )
            .shimmer(
              delay: const Duration(milliseconds: 1200),
              duration: const Duration(milliseconds: 1500),
              color: Colors.white.withValues(alpha: 0.4),
            )
            .then()
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scaleXY(
              begin: 1.0,
              end: 1.05,
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeInOut,
            ),
      ),
    );
  }
}
