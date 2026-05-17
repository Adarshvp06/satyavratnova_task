import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:satyavratnova_task/core/widgets/no_item_found.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme_extension.dart';
import '../../../core/widgets/common_appbar.dart';
import '../../../core/widgets/error_widget_with_retry.dart';
import '../model/post_model.dart';
import '../viewmodel/home_viewmodel.dart';
import '../widgets/homescreen_item.dart';
import '../widgets/homescreen_item_shimmer.dart';

/// Home screen displaying paginated posts using infinite scroll pagination.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String path = '/home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(),
        body: Column(
          children: [
            TabBar(
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              unselectedLabelColor: textSecondary,
              labelStyle: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: context.bodyMedium,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: secondaryColor.withValues(alpha: 0.2),
              tabs: const [
                Tab(text: 'Post'),
                Tab(text: 'Nova'),
                Tab(text: 'News'),
                Tab(text: 'Articles'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: const [
                  _PostsFeedWidget(),
                  _PostsFeedWidget(),
                  _PostsFeedWidget(),
                  _PostsFeedWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostsFeedWidget extends StatelessWidget {
  const _PostsFeedWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return RefreshIndicator(
          color: primaryColor,
          onRefresh: () async => viewModel.pagingController.refresh(),
          child: PagedListView<int, PostModel>.separated(
            pagingController: viewModel.pagingController,
            padding: const EdgeInsets.symmetric(
              vertical: paddingLarge,
              horizontal: paddingLarge,
            ),
            separatorBuilder: (context, index) => gapLarge,
            builderDelegate: PagedChildBuilderDelegate<PostModel>(
              itemBuilder: (context, post, index) =>
                  HomeScreenItem(post: post),

              firstPageProgressIndicatorBuilder: (context) => Column(
                children: List.generate(
                  3,
                  (index) => const HomeScreenItemShimmer(),
                ),
              ),

              newPageProgressIndicatorBuilder: (context) =>
                  const HomeScreenItemShimmer(),

              firstPageErrorIndicatorBuilder: (context) => ErrorWidgetWithRetry(
                message: viewModel.pagingController.error.toString(),
                onRetry: () => viewModel.pagingController.refresh(),
              ),

              newPageErrorIndicatorBuilder: (context) => ErrorWidgetWithRetry(
                message: viewModel.pagingController.error.toString(),
                onRetry: () =>
                    viewModel.pagingController.retryLastFailedRequest(),
                isCompact: true,
              ),

              noItemsFoundIndicatorBuilder: (context) => const NoItemFound(),
            ),
          ),
        );
      },
    );
  }
}
