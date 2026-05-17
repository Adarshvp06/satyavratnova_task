import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../gen/assets.gen.dart';
import '../model/post_model.dart';
import 'post_content.dart';
import 'post_header.dart';
import 'post_reaction_bar.dart';
import 'post_tags.dart';

/// Reusable card widget composing the full post layout matching the design reference.
///
class HomeScreenItem extends StatelessWidget {
  final PostModel post;

  const HomeScreenItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post),
          gap,

          PostContent(title: post.title ?? 'N/A', body: post.body ?? 'N/A'),
          gap,

          PostTags(tags: post.tags!),
          gapLarge,
          ClipRRect(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/seed/post${post.id}/600/400',
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 200.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>           
                  Assets.png.errorimagePlaceholder.image(fit: BoxFit.cover,width: double.infinity,height: 200.w),

              ),
            ),
       
          gapLarge,
        
          PostReactionBar(
            likes: post.likes ?? 0,
            dislikes: post.dislikes ?? 0,
            views: post.views ?? 0,
          ),
      
      ]) 
    );
    
  }
}
