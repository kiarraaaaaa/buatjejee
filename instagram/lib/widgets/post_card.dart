import 'package:flutter/material.dart';
import '../models/post_item.dart';
import 'dart:math';

class PostCard extends StatefulWidget {
  final PostItem post;
  final VoidCallback onLikeToggle;

  const PostCard({
    super.key,
    required this.post,
    required this.onLikeToggle,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {

  final Random random = Random();

  bool showHeart = false;

  late AnimationController heartController;
  late Animation<double> heartAnimation;

  late List<String> generatedUsers;

  final List<String> commentUsers = [
    "anin_prettycute",
    "nath_hotAF",
    "arum_fineshit",
    "krys_yourmommy",
    "skyheaven",
    "king_kiseee",
    "meemaaa_agerr",
    "ibie_lol",
    "ran_rannn",
    "artemis_cinaaa",
    "agnesya_syasyaaa"
  ];

  @override
  void initState() {
    super.initState();

    heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    heartAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: heartController,
        curve: Curves.easeOut,
      ),
    );

    generatedUsers = widget.post.comments.map((e) {
      return commentUsers[random.nextInt(commentUsers.length)];
    }).toList();
  }

  void onDoubleTapLike() {

    if (!widget.post.isLiked) {
      widget.onLikeToggle();
    }

    setState(() {
      showHeart = true;
    });

    heartController.forward(from: 0);

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          showHeart = false;
        });
      }
    });
  }

  @override
  void dispose() {
    heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final post = widget.post;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(post.userAvatar),
          ),

          title: Row(
            children: [

              Text(
                post.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (post.username.toLowerCase() == "xeno_foster")
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 18,
                  ),
                ),

            ],
          ),

          subtitle: const Text(
            'night ride',
            style: TextStyle(fontSize: 12),
          ),

          trailing: const Icon(Icons.more_vert),
        ),

        GestureDetector(
          onDoubleTap: onDoubleTapLike,
          child: Stack(
            alignment: Alignment.center,
            children: [

              AspectRatio(
                aspectRatio: 1.5,
                child: Image.asset(
                  post.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              if (showHeart)
                ScaleTransition(
                  scale: heartAnimation,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 120,
                  ),
                ),

            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
          child: Row(
            children: [

              IconButton(
                onPressed: widget.onLikeToggle,
                icon: Icon(
                  post.isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: post.isLiked
                      ? Colors.red
                      : Colors.white,
                ),
              ),

              const Icon(Icons.mode_comment_outlined, size: 28),

              const SizedBox(width: 14),

              const Icon(Icons.send, size: 26),

              const Spacer(),

              const Icon(Icons.bookmark_border, size: 28),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '${post.likes} likes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white),
              children: [

                TextSpan(
                  text: '${post.username} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextSpan(text: post.caption),

              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: post.comments.asMap().entries.map((entry) {

              int index = entry.key;
              String comment = entry.value;
              String user = generatedUsers[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                    children: [

                      TextSpan(
                        text: '$user ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(text: comment),

                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Text(
            '2 HOURS AGO',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}