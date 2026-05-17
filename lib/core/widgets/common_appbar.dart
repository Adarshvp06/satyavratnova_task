import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:satyavratnova_task/core/constants/constants.dart';
import 'package:satyavratnova_task/core/theme/theme_extension.dart';
import '../../features/navigation/viewmodel/navigation_viewmodel.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          final rootScaffold = context
              .findRootAncestorStateOfType<ScaffoldState>();
          if (rootScaffold?.hasDrawer ?? false) {
            rootScaffold?.openDrawer();
          }
        },
        icon: Icon(Icons.menu_rounded, color: primaryColor, size: 20.sp),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "BHARATN",
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: primaryColor,
              letterSpacing: 1.2,
            ),
          ),
          Gap(1.w),
          CustomPaint(
            size: Size(16.sp, 16.sp),
            painter: _ChakraPainter(color: primaryColor),
          ),
          Gap(1.w),
          Text(
            "VA",
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: primaryColor,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: padding),
          child: Consumer<NavigationViewModel>(
            builder: (context, viewModel, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: primaryColor, size: 20.sp),
                  gapTiny,
                  Text(
                    viewModel.currentCity,
                    style: context.bodyMedium?.copyWith(color: primaryColor),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChakraPainter extends CustomPainter {
  final Color color;
  _ChakraPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5.w
      ..isAntiAlias = true;

    // Outer ring
    canvas.drawCircle(center, radius - (paint.strokeWidth / 2), paint);

    // Inner ring
    paint.strokeWidth = 0.8.w;
    final innerRadius = radius * 0.65;
    canvas.drawCircle(center, innerRadius, paint);

    // Central dot
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    canvas.drawCircle(center, radius * 0.22, fillPaint);

    // Spokes between central dot and inner ring
    final int spokeCount = 16;
    paint.strokeWidth = 0.6.w;
    for (int i = 0; i < spokeCount; i++) {
      final double angle = (i * 2 * math.pi) / spokeCount;
      final Offset start = Offset(
        center.dx + (radius * 0.22) * math.cos(angle),
        center.dy + (radius * 0.22) * math.sin(angle),
      );
      final Offset end = Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
