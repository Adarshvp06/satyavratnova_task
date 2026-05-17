import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satyavratnova_task/core/theme/theme_extension.dart';
import 'package:satyavratnova_task/core/widgets/common_appbar.dart';
import '../../../core/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60.r),
              child: CachedNetworkImage(
                imageUrl: randomProfileImage,
                width: 120.r,
                height: 120.r,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: primaryColor.withValues(alpha: 0.1),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: primaryColor.withValues(alpha: 0.1),
                  child: Icon(Icons.person, size: 50.sp, color: primaryColor),
                ),
              ),
            ),
            gap,
            Text(
              randomName,
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
