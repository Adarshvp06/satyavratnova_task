import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme_extension.dart';

/// Reusable widget displaying a horizontal row of tags as styled chips.
class PostTags extends StatelessWidget {
  final List<String> tags;

  const PostTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: paddingSmall,
      runSpacing: paddingSmall,
      children: tags.map((tag) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: paddingSmall,
          ),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(paddingLarge),
          ),
          child: Text(
            '#$tag',
            style: context.bodySmall?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
            ),
          ),
        );
      }).toList(),
    );
  }
}
