import 'package:flutter/material.dart';
import '../models/post_item.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  final List<PostItem> posts;
  final Function(String) onLikeToggle;

  const HomeScreen({
    super.key,
    required this.posts,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  Text(
                    'INSTAGRAM',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.favorite_border),
                  SizedBox(width: 16),
                  Icon(Icons.send_outlined),
                ],
              ),
            );
          }

          final post = posts[index - 1];
          return PostCard(
            post: post,
            onLikeToggle: () => onLikeToggle(post.id),
          );
        },
      ),
    );
  }
}
