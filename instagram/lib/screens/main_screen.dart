import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/post_item.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'likes_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late List<PostItem> posts;

  @override
  void initState() {
    super.initState();
    posts = DummyData.posts();
  }

  void toggleLike(String postId) {
    setState(() {
      final post = posts.firstWhere((p) => p.id == postId);
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      /// HOME
      HomeScreen(
        posts: posts,
        onLikeToggle: toggleLike,
      ),

      /// PLAYLIST SCREEN
      const LikesScreen(),

      /// PROFILE
      ProfileScreen(
        posts: posts,
        profileImage: DummyData.profileImage,
        profileName: DummyData.profileName,
        username: DummyData.username,
        onLikeToggle: toggleLike,
      ),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}