class Post {
  final String title;
  final String? imageUrl;
  final String? userId;
  final String? documentId;

  Post({
    required this.userId,
    required this.title,
    this.imageUrl,
    this.documentId,
  });

  Post.fromData(Map<String, dynamic> data, this.documentId)
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
