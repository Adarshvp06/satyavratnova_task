import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satyavratnova_task/features/home/viewmodel/home_viewmodel.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme_extension.dart';

class PostContent extends StatelessWidget {
  final String title;
  final String body;

  const PostContent({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          final displayBody = viewModel.isExpanded
              ? body
              : (body.length > 150 ? '${body.substring(0, 150)}...' : body);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              gapTiny,
              Text(
                displayBody,
                style: context.bodyMedium?.copyWith(
                  color: textSecondary,
                ),
              ),
              if (body.length > 150) ...[
                gapTiny,
                GestureDetector(
                  onTap: () => viewModel.toggleExpanded(),
                  child: Text(
                    viewModel.isExpanded ? 'Show Less' : 'Read More',
                    style: context.bodyMedium?.copyWith(
                      color:primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
