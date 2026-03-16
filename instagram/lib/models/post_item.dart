class PostItem {
  final String id;
  final String username;
  final String userFullName;
  final String userAvatar;
  final String imageUrl;
  final String caption;
  final List<String> comments;
  int likes;
  bool isLiked;

  PostItem({
    required this.id,
    required this.username,
    required this.userFullName,
    required this.userAvatar,
    required this.imageUrl,
    required this.caption,
    required this.comments,
    required this.likes,
    this.isLiked = false,
  });
}
