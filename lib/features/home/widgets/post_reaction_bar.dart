import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme_extension.dart';

/// Reusable widget displaying post reactions (likes, dislikes, views, share).
class PostReactionBar extends StatelessWidget {
  final int likes;
  final int dislikes;
  final int views;

  const PostReactionBar({
    super.key,
    required this.likes,
    required this.dislikes,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side reactions
        Row(
          children: [
            _ReactionItem(
              icon: Icons.favorite_border,
              count: likes,
            ),
            SizedBox(width: paddingLarge),
            _ReactionItem(
              icon: Icons.chat_bubble_outline,
              count: dislikes,
            ),
            SizedBox(width: paddingLarge),
            _ReactionItem(
              icon: Icons.remove_red_eye_outlined,
              count: views,
            ),
          ],
        ),
        Icon(
          Icons.share_outlined,
          size: 20.sp,
          color: textSecondary,
        ),
      ],
    );
  }
}

class _ReactionItem extends StatelessWidget {
  final IconData icon;
  final int count;

  const _ReactionItem({
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: textSecondary,
        ),
        gapTiny,
        Text(
          _formatCount(count),
          style: context.bodySmall?.copyWith(
            color: textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
