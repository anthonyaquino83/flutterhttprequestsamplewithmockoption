class Post {
  final String id;
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'userId': int userId,
        'title': String title,
        'body': String body,
      } =>
        Post(
          id: id,
          userId: userId,
          title: title,
          body: body,
        ),
      _ => throw const FormatException('Failed to load Post.'),
    };
  }
}
