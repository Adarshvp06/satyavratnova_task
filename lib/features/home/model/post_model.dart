/// Model representing a post item fetched from the API.
class PostModel {
  final int? id;
  final String? title;
  final String? body;
  final List<String>? tags;
  final int? likes;
  final int? dislikes;
  final int? views;
  final int? userId;

  PostModel({
     this.id,
     this.title,
     this.body,
     this.tags,
     this.likes,
     this.dislikes,
     this.views,
     this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final reactions = json['reactions'] as Map<String, dynamic>? ?? {};
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      tags: json['tags'] != null ? (json['tags'] as List<dynamic>).map((e) => e.toString()).toList() : [],
      likes: reactions['likes'],
      dislikes: reactions['dislikes'],
      views: json['views'],
      userId: json['userId'],
    );
  }


}
