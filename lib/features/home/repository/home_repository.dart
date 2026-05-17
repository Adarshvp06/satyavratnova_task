import 'dart:developer';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/custom_exception.dart';
import '../../../core/services/api_service.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';

class HomeRepository {
  final ApiService _apiService;

  HomeRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  Future<PostResponse> getPosts({required int skip, required int limit}) async {
    try {
      final response = await _apiService.get(
        ApiConstants.posts,
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data as Map<String, dynamic>;
      final postsList = data['posts'] as List<dynamic>? ?? [];
      final total = data['total'] as int? ?? 0;
      final posts = postsList
          .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return PostResponse(posts: posts, total: total);
    } catch (e) {
      log('Error in HomeRepository getPosts: $e');
      throw CustomException.fromError(e);
    }
  }

  Future<UserModel> getUser(int userId) async {
    try {
      final response = await _apiService.get('${ApiConstants.users}/$userId');
      final data = response.data;
      return UserModel.fromJson(data);
    } catch (e) {
      log('Error in HomeRepository getUser: $e');
      throw CustomException.fromError(e);
    }
  }
}

class PostResponse {
  final List<PostModel> posts;
  final int total;

  PostResponse({required this.posts, required this.total});
}
