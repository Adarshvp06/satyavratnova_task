import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../model/post_model.dart';
import '../model/user_model.dart';
import '../repository/home_repository.dart';

/// ViewModel managing state, pagination, and business logic for the Home feature.
class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository;

  /// Number of items fetched per page.
  static const int pageSize = 10;

  /// Paging controller for infinite scroll pagination.
  final PagingController<int, PostModel> pagingController =
      PagingController(firstPageKey: 0);

  final Map<int, UserModel> _users = {};
  final Map<int, bool> _loadingUsers = {};
  final Map<int, String> _userErrors = {};

  Map<int, UserModel> get users => _users;
  Map<int, bool> get loadingUsers => _loadingUsers;
  Map<int, String> get userErrors => _userErrors;

  HomeViewModel({HomeRepository? repository}): _repository = repository ?? HomeRepository() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await _repository.getPosts(
        skip: pageKey,
        limit: pageSize,
      );
      final newItems = response.posts;
      final isLastPage = pageKey + newItems.length >= response.total;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      log('Error in HomeViewModel _fetchPage: $e');
      pagingController.error = e;
    }
  }

  /// Fetches a user by ID and caches the result.
  Future<void> fetchUser(int userId) async {
    if (_users.containsKey(userId) || (_loadingUsers[userId] ?? false)) {
      return;
    }

    _loadingUsers[userId] = true;
    _userErrors.remove(userId);
    notifyListeners();

    try {
      final user = await _repository.getUser(userId);
      _users[userId] = user;
    } catch (e) {
      log('Error in HomeViewModel fetchUser: $e');
      _userErrors[userId] = e.toString();
    } finally {
      _loadingUsers[userId] = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }


  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}

