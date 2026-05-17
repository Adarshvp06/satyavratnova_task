import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';
import '../theme/theme_extension.dart';

class ErrorWidgetWithRetry extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final IconData icon;
  final bool isCompact;

  const ErrorWidgetWithRetry({
    super.key,
    required this.onRetry,
    this.message = 'Something went wrong. Please try again.',
    this.icon = Icons.error_outline_rounded,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Padding(
        padding: const EdgeInsets.all(paddingLarge),
        child: Center(
          child: TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, color: primaryColor),
            label: Text(
              'Retry',
              style: context.bodyMedium?.copyWith(color: primaryColor),
            ),
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 50.sp, color: Colors.redAccent),
            gap,
            Text(
              message,
              style: context.bodyMedium?.copyWith(color: textSecondary),
              textAlign: TextAlign.center,
            ),
            gapLarge,
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh_rounded, size: 18.sp),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: paddingLarge,
                  vertical: padding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
