import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme_extension.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../viewmodel/home_viewmodel.dart';

class PostHeader extends StatefulWidget {
  final PostModel post;

  const PostHeader({super.key, required this.post});

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  @override
  void initState() {
    super.initState();
    final userId = widget.post.userId;
    if (userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<HomeViewModel>().fetchUser(userId);
        }
      });
    }
  }

  Widget _buildFallbackAvatar(
    BuildContext context,
    String? firstName,
    int? userId,
  ) {
    final initial = firstName != null && firstName.isNotEmpty
        ? firstName[0].toUpperCase()
        : 'U';
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: primaryColor.withValues(alpha: 0.1),
      child: Text(
        '$initial${userId != null ? userId % 100 : ''}',
        style: context.bodySmall?.copyWith(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          CircleAvatar(radius: 20.r, backgroundColor: Colors.white),
          gapSmall,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 14.w,
                width: 120.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(paddingSmall),
                ),
              ),
              gapTiny,
              Container(
                height: 12.w,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(paddingSmall),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, UserModel user) {
    final name = user.firstName != null
        ? '${user.firstName} ${user.lastName ?? ''}'.trim()
        : 'User ${widget.post.userId}';
    final state = user.address?.state;
    final country = user.address?.country;
    final location = (state != null && country != null)
        ? '$state, $country'
        : state ?? country ?? 'Mumbai, India';

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: user.image != null && user.image!.isNotEmpty
              ? Image.network(
                  user.image!,
                  width: 40.r,
                  height: 40.r,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return _buildFallbackAvatar(
                      context,
                      user.firstName,
                      widget.post.userId,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return _buildFallbackAvatar(
                      context,
                      user.firstName,
                      widget.post.userId,
                    );
                  },
                )
              : _buildFallbackAvatar(
                  context,
                  user.firstName,
                  widget.post.userId,
                ),
        ),
        gapSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: context.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  gapTiny,
                  Icon(Icons.verified, size: 16.sp, color: Colors.blue),
                ],
              ),
              Text(
                location,
                style: context.bodySmall?.copyWith(color: textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Row(
      children: [
        _buildFallbackAvatar(context, null, widget.post.userId),
        gapSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'User ${widget.post.userId}',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  gapTiny,
                  Icon(Icons.verified, size: 16.sp, color: Colors.blue),
                ],
              ),
              Text(
                'Mumbai, India',
                style: context.bodySmall?.copyWith(color: textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Row(
      children: [
        _buildFallbackAvatar(context, null, widget.post.userId),
        gapSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'User ${widget.post.userId}',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  gapTiny,
                  Icon(Icons.verified, size: 16.sp, color: Colors.blue),
                ],
              ),
              Text(
                'N/A',
                style: context.bodySmall?.copyWith(color: textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final user = viewModel.users[widget.post.userId];
        final isLoading = viewModel.loadingUsers[widget.post.userId] ?? false;
        final hasError = viewModel.userErrors.containsKey(widget.post.userId);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: isLoading && user == null
                  ? _buildShimmerLoading()
                  : hasError && user == null
                  ? _buildErrorState(context)
                  : user == null
                  ? _buildEmptyState(context)
                  : _buildSuccessState(context, user),
            ),
            gapSmall,
            Text(
              DateFormat('dd MMM yyyy').format(DateTime.now()),
              style: context.bodySmall?.copyWith(color: textSecondary),
            ),
            gapSmall,
            Icon(Icons.more_vert, size: 20.sp, color: textSecondary),
          ],
        );
      },
    );
  }
}
