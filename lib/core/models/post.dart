class Post {
  final String title;
  final String? imageUrl;
  final String? userId;
  final String? documentId;
  final String? imageFileName;

  Post({
    required this.userId,
    required this.title,
    this.imageUrl,
    this.documentId,
    this.imageFileName,
  });

  Post.fromData(Map<String, dynamic> data, this.documentId)
      : title = data['title'],
        imageUrl = data['imageUrl'],
        userId = data['userId'],
        imageFileName = data['imageFileName'];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
    };
  }
}
