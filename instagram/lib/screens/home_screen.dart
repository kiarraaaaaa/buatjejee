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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List<AnimationController>.generate(
      widget.posts.length + 2,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
    }).toList();

    // Staggered animation
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted && i < _controllers.length) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: widget.posts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return FadeTransition(
              opacity: _animations[0],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.3, 0),
                  end: Offset.zero,
                ).animate(_animations[0]),
                child: const Padding(
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
                ),
              ),
            );
          }

          if (index == 1) {
            return FadeTransition(
              opacity: _animations[1],
              child: StoryWidget(
                stories: [
                  'images/tele.jpg',
                  'images/tele1.jpg',
                  'images/tele2.jpg',
                  'images/tele3.jpg',
                  'images/tele5.jpg',
                ],
              ),
            );
          }

          final post = widget.posts[index - 2];
          return FadeTransition(
            opacity: _animations[index],
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(_animations[index]),
              child: PostCard(
                post: post,
                onLikeToggle: () => widget.onLikeToggle(post.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
