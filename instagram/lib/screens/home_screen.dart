import 'package:flutter/material.dart';
import '../models/post_item.dart';
import '../widgets/post_card.dart';
import '../widgets/story_widget.dart';
import 'dm_story_screen.dart';
import 'memories_screen.dart';

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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      const Text(
                        'INSTAGRAM',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 420),
                              reverseTransitionDuration: const Duration(milliseconds: 320),
                              pageBuilder: (context, animation, secondaryAnimation) => const MemoriesScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                final slide = Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(
                                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                                );
                                final scale = Tween<double>(begin: 0.96, end: 1.0).animate(
                                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                                );
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: slide,
                                    child: ScaleTransition(
                                      scale: scale,
                                      child: child,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF1D1D1D),
                            border: Border.all(color: Colors.white12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(64),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 420),
                              reverseTransitionDuration: const Duration(milliseconds: 320),
                              pageBuilder: (context, animation, secondaryAnimation) => const DmStoryScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                final slide = Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(
                                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                                );
                                final scale = Tween<double>(begin: 0.96, end: 1.0).animate(
                                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                                );
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: slide,
                                    child: ScaleTransition(
                                      scale: scale,
                                      child: child,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF1D1D1D),
                            border: Border.all(color: Colors.white12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(64),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
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
