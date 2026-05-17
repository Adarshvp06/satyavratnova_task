import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme_extension.dart';
import '../model/navigation_tab.dart';
import '../viewmodel/navigation_viewmodel.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  static const String path = '/navigation';

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, viewModel, child) {
        final currentTab = viewModel.currentTab;
        return Scaffold(
          extendBody: true,
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Center(
              child: Text(
                "No items",
                style: context.titleMedium?.copyWith(color: textSecondary),
              ),
            ),
          ),
          body: IndexedStack(
            index: currentTab.index,
            children: NavigationTab.values.map((tab) => tab.body).toList(),
          ),
          floatingActionButton: GestureDetector(
            onTap: () => viewModel.setTab(NavigationTab.create),
            child: Container(
              width: 68.w,
              height: 68.w,
              padding: EdgeInsets.all(paddingSmall),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: CustomPaint(
                  painter: _SunburstPainter(),
                  child: Center(
                    child: Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            height: 85.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 15,
                  offset: const Offset(0, -5),
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(largeBorderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavBarItem(
                  tab: NavigationTab.home,
                  currentTab: currentTab,
                  onTap: () => viewModel.setTab(NavigationTab.home),
                ),
                _NavBarItem(
                  tab: NavigationTab.search,
                  currentTab: currentTab,
                  onTap: () => viewModel.setTab(NavigationTab.search),
                ),
                _NavBarItem(
                  tab: NavigationTab.brand,
                  currentTab: currentTab,
                  onTap: () => viewModel.setTab(NavigationTab.brand),
                ),
                gapXL, // Space for docked FAB
                _NavBarItem(
                  tab: NavigationTab.video,
                  currentTab: currentTab,
                  onTap: () => viewModel.setTab(NavigationTab.video),
                ),
                _NavBarItem(
                  tab: NavigationTab.notification,
                  currentTab: currentTab,
                  onTap: () => viewModel.setTab(NavigationTab.notification),
                ),
                _NavBarItem(
                  tab: NavigationTab.profile,
                  currentTab: currentTab,
                  onTap: () => viewModel.setTab(NavigationTab.profile),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final NavigationTab tab;
  final NavigationTab currentTab;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.tab,
    required this.currentTab,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentTab == tab;
    final color = isSelected ? primaryColor : secondaryColor;

    Widget content;

    if (tab == NavigationTab.brand) {
      content = Text(
        "BN",
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: -2.sp,
          height: 1,
        ),
      );
    } else if (tab == NavigationTab.video) {
      content = SizedBox(
        width: 32.w,
        height: 32.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              isSelected ? Icons.play_circle_filled : Icons.play_circle_outline,
              size: 28.sp,
              color: color,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 6.sp,
                height: 6.sp,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : secondaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (tab == NavigationTab.profile) {
      content = Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? primaryColor
                : secondaryColor.withValues(alpha: 0.5),
            width: isSelected ? 2.sp : 1.sp,
          ),
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: randomProfileImage,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[200]),
            errorWidget: (context, url, error) =>
                Icon(Icons.person, size: 18.sp, color: secondaryColor),
          ),
        ),
      );
    } else {
      content = Icon(
        isSelected ? tab.activeIcon : tab.icon,
        size: 28.sp,
        color: color,
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: defaultBorderRadius,
          vertical: padding,
        ),
        child: content,
      ),
    );
  }
}

class _SunburstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    const int rayCount = 32;
    for (int i = 0; i < rayCount; i++) {
      final angle = (i * 2 * 3.141592653589793) / rayCount;
      final startPoint = Offset(
        center.dx + (radius * 0.35) * math.cos(angle),
        center.dy + (radius * 0.35) * math.sin(angle),
      );
      final endPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
