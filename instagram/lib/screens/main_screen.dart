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

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int currentIndex = 0;
  late List<PostItem> posts;
  late AnimationController _pageTransitionController;
  late Animation<double> _pageOpacity;
  late Animation<Offset> _pageSlide;
  late Animation<double> _pageScale;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    posts = DummyData.posts();
    _pageTransitionController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _pageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pageTransitionController, curve: Curves.easeIn),
    );
    _pageSlide = Tween<Offset>(begin: const Offset(0.5, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _pageTransitionController, curve: Curves.easeOutCubic),
    );
    _pageScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _pageTransitionController, curve: Curves.easeOut),
    );
    _pageTransitionController.forward();
  }

  @override
  void dispose() {
    _pageTransitionController.dispose();
    super.dispose();
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
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (!_isAnimating) {
            // Swipe right - go to previous screen
            if (details.primaryVelocity! > 0) {
              if (currentIndex > 0) {
                _handleTabChange(currentIndex - 1);
              }
            }
            // Swipe left - go to next screen
            else if (details.primaryVelocity! < 0) {
              if (currentIndex < 2) {
                _handleTabChange(currentIndex + 1);
              }
            }
          }
        },
        child: FadeTransition(
          opacity: _pageOpacity,
          child: SlideTransition(
            position: _pageSlide,
            child: ScaleTransition(
              scale: _pageScale,
              child: screens[currentIndex],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex && !_isAnimating) {
            _handleTabChange(index);
          }
        },
      ),
    );
  }

  void _handleTabChange(int index) {
    _isAnimating = true;
    _pageTransitionController.reset();
    setState(() {
      currentIndex = index;
    });
    _pageTransitionController.forward().then((_) {
      if (mounted) {
        _isAnimating = false;
      }
    });
  }
}