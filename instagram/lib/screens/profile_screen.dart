import 'package:flutter/material.dart';
import '../models/post_item.dart';
import 'chat_screen.dart';

class ProfileScreen extends StatelessWidget {
  final List<PostItem> posts;
  final String profileImage;
  final String profileName;
  final String username;
  final Function(String) onLikeToggle;

  const ProfileScreen({
    super.key,
    required this.posts,
    required this.profileImage,
    required this.profileName,
    required this.username,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.verified,
              color: Colors.blue,
              size: 18,
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundImage: AssetImage(profileImage),
                      ),
                      const SizedBox(height: 10),

                      // NAMA TANPA CENTANG BIRU
                      Text(
                        profileName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ProfileStat(
                          value: posts.length.toString(),
                          label: 'Posts',
                        ),
                        const _ProfileStat(value: '2M', label: 'Followers'),
                        const _ProfileStat(value: '1', label: 'Following'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rider | Street frames | Black & white mood\nBuilt for speed, style, and silence.',
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade700),
                      ),
                      child: const Text('Edit profile'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChatScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade700),
                      ),
                      child: const Text('Secret Chat'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            const Divider(color: Colors.white24, height: 1),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.grid_on),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.person_pin_outlined),
                ),
              ],
            ),

            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                final post = posts[index];
                return Image.asset(
                  post.imageUrl,
                  fit: BoxFit.cover,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(label),
      ],
    );
  }
}