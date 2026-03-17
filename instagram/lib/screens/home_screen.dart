import 'package:flutter/material.dart';
import '../models/post_item.dart';
import '../widgets/post_card.dart';
import '../widgets/story_widget.dart';

class HomeScreen extends StatefulWidget {
  final List<PostItem> posts;
  final Function(String) onLikeToggle;

  const HomeScreen({
    super.key,
    required this.posts,
    required this.onLikeToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      if (widget.posts.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return SafeArea(
        child: ListView.builder(
          itemCount: widget.posts.length + 2,
          itemBuilder: (context, index) {
            try {
              // Header
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
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

              // Story widget
              if (index == 1) {
                return const StoryWidget(
                  stories: [
                    'images/tele20.jpg',
                    'images/tele.jpg',
                    'images/tele21.jpg',
                    'images/tele22.jpg',
                    'images/tele23.jpg',
                  ],
                );
              }

              // Posts
              final postIndex = index - 2;
              if (postIndex < 0 || postIndex >= widget.posts.length) {
                return const SizedBox.shrink();
              }

              final post = widget.posts[postIndex];
              return PostCard(
                post: post,
                onLikeToggle: () => widget.onLikeToggle(post.id),
              );
            } catch (e) {
              debugPrint('Error building item $index: $e');
              return const SizedBox.shrink();
            }
          },
        ),
      );
    } catch (e) {
      debugPrint('Error in HomeScreen build: $e');
      return Center(
        child: Text('Error loading home screen: $e'),
      );
    }
  }
}
