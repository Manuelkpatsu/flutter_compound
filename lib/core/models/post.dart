class Post {
  final String title;
  final String? imageUrl;
  final String? userId;

  Post({
    this.userId,
    required this.title,
    this.imageUrl,
  });

  Post.fromData(Map<String, dynamic> data)
      : title = data['title'],
        imageUrl = data['imageUrl'],
        userId = data['userId'];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
