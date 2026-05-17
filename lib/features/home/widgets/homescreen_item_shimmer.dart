import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/constants.dart';

class HomeScreenItemShimmer extends StatelessWidget {
  const HomeScreenItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: secondaryColor.withValues(alpha: 0.15),
            width: 0.5.w,
          ),
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.white,
                ),
                gapSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14.w,
                        width: 140.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(paddingSmall),
                        ),
                      ),
                      gapTiny,
                      Container(
                        height: 12.w,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(paddingSmall),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            gapLarge,

            Container(
              height: 14.w,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(paddingSmall),
              ),
            ),
            gapSmall,
            Container(
              height: 14.w,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(paddingSmall),
              ),
            ),
            gapLarge,

            Container(
              height: 160.w,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
