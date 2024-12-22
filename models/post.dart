import 'package:floor/floor.dart';

@entity
class Posts {
  @primaryKey
  final int id; 

  final String title;
  final String body;
  final int userId;
  final List<String> tags;
  final int reactions;


  Posts({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
  });


  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int,
      tags: (json['tags'] as List).cast<String>(),
      reactions: json['reactions'] as int,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'tags': tags,
      'reactions': reactions,
    };
  }
}
