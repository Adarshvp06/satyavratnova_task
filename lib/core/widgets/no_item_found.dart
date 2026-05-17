import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';
import '../theme/theme_extension.dart';

class NoItemFound extends StatelessWidget {
  final String message;
  final IconData icon;
  const NoItemFound({
    super.key,
    this.message = 'No items found',
    this.icon = Icons.sentiment_satisfied_alt_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 50.sp, color: secondaryColor),
        gap,
        Text(message, style: context.bodyMedium),
        gap,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_downward_rounded,
              size: 10.sp,
              color: primaryColor,
            ),
            gapSmall,
            Text(
              'Pull down to refresh',
              style: context.bodySmall?.copyWith(color: primaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
