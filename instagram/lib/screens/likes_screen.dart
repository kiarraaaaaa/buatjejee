import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/audio_controller.dart';
import '../widgets/mini_player.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final AudioController audioController = AudioController();

  final List<Map<String, dynamic>> songs = [
    {
      "title": "Him and I",
      "artist": "G-Eazy & Halsey",
      "image": "images/tele11.jpg",
      "audio": "audio/HimandI.mp3",
      "liked": false,
    },
    {
      "title": "Party 4 U",
      "artist": "Charli XCX",
      "image": "images/tele9.jpg",
      "audio": "audio/Party.mp3",
      "liked": false,
    },
    {
      "title": "Rock That Body x Outside",
      "artist": "Nightdrives",
      "image": "images/tele8.jpg",
      "audio": "audio/Rock.mp3",
      "liked": false,
    },
    {
      "title": "Fetish",
      "artist": "Selena Gomez ft. Gucci Mane",
      "image": "images/tele10.jpg",
      "audio": "audio/Fetish.mp3",
      "liked": false,
    },
    {
      "title": "Again",
      "artist": "Noah Cyrus",
      "image": "images/tele7.jpg",
      "audio": "audio/Again.mp3",
      "liked": false,
    },
    {
      "title": "Flatline",
      "artist": "Justin Bieber",
      "image": "images/tele6.jpg",
      "audio": "audio/flatline.mp3",
      "liked": false,
    },
    {
      "title": "Shameless",
      "artist": "Camilla Cabello",
      "image": "images/tele12.jpg",
      "audio": "audio/Shameless.mp3",
      "liked": false,
    },
    {
      "title": "Boyfriend",
      "artist": "Justin Bieber",
      "image": "images/tele13.jpg",
      "audio": "audio/Boyfriend.mp3",
      "liked": false,
    },
    {
      "title": "The Fate of Ophelia",
      "artist": "Taylor Swift",
      "image": "images/tele14.jpg",
      "audio": "audio/Ophelia.mp3",
      "liked": false,
    },
    {
      "title": "The Man Who Can't Be Moved",
      "artist": "The Script",
      "image": "images/tele15.jpg",
      "audio": "audio/TheMan.mp3",
      "liked": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadLikedStatus();
    audioController.init();
    audioController.setPlaylist(songs);
  }

  Future<void> _loadLikedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < songs.length; i++) {
        songs[i]["liked"] = prefs.getBool('liked_$i') ?? false;
      }
    });
  }

  Future<void> _saveLikedStatus(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('liked_$index', songs[index]["liked"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xff090909),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff120c1c),
                  Color(0xff090909),
                  Color(0xff090909),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Liked Songs",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xff8B5CF6).withOpacity(0.9),
                                      const Color(0xffEC4899).withOpacity(0.7),
                                      const Color(0xff111111),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff8B5CF6)
                                          .withOpacity(0.2),
                                      blurRadius: 25,
                                      offset: const Offset(0, 12),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(22),
                                      child: Image.asset(
                                        "images/tele1.jpg",
                                        height: 220,
                                        width: 220,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    const Text(
                                      "Ride or Die",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "${songs.where((e) => e["liked"] == true).length} songs you vibe with the most",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            onPressed: songs.isEmpty
                                                ? null
                                                : () {
                                                    audioController.setPlaylist(
                                                      songs,
                                                    );
                                                    audioController.playSong(
                                                      songs[0]["audio"],
                                                      0,
                                                    );
                                                  },
                                            icon: const Icon(Icons.play_arrow),
                                            label: const Text("Play"),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 14,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: OutlinedButton.icon(
                                            onPressed: songs.isEmpty
                                                ? null
                                                : () {
                                                    final likedSongs = songs
                                                        .where(
                                                          (s) =>
                                                              s["liked"] == true,
                                                        )
                                                        .toList();

                                                    if (likedSongs.isEmpty) {
                                                      audioController.setPlaylist(
                                                        songs,
                                                      );
                                                      audioController.playSong(
                                                        songs[0]["audio"],
                                                        0,
                                                      );
                                                    } else {
                                                      final firstLiked =
                                                          songs.indexOf(
                                                        likedSongs[0],
                                                      );
                                                      audioController.setPlaylist(
                                                        songs,
                                                      );
                                                      audioController.playSong(
                                                        songs[firstLiked]
                                                            ["audio"],
                                                        firstLiked,
                                                      );
                                                    }
                                                  },
                                            icon: const Icon(Icons.favorite),
                                            label: const Text("Play Liked"),
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.25),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 14,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final song = songs[index];

                              return ValueListenableBuilder<int>(
                                valueListenable:
                                    audioController.currentSongNotifier,
                                builder: (context, currentIndex, child) {
                                  final isCurrent = currentIndex == index;

                                  return GestureDetector(
                                    onTap: () {
                                      audioController.setPlaylist(songs);
                                      audioController.playSong(
                                        song["audio"],
                                        index,
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 7,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: isCurrent
                                            ? const Color(0xff1E1B2E)
                                            : Colors.white.withOpacity(0.05),
                                        border: Border.all(
                                          color: isCurrent
                                              ? const Color(0xff8B5CF6)
                                              : Colors.white.withOpacity(0.06),
                                        ),
                                        boxShadow: isCurrent
                                            ? [
                                                BoxShadow(
                                                  color: const Color(0xff8B5CF6)
                                                      .withOpacity(0.18),
                                                  blurRadius: 18,
                                                  offset: const Offset(0, 8),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.asset(
                                                  song["image"],
                                                  width: 66,
                                                  height: 66,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              if (isCurrent)
                                                Container(
                                                  width: 66,
                                                  height: 66,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.35),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      16,
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.graphic_eq_rounded,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  song["title"],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: isCurrent
                                                        ? FontWeight.w800
                                                        : FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  song["artist"],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                song["liked"] = !song["liked"];
                                              });
                                              _saveLikedStatus(index);
                                            },
                                            icon: AnimatedScale(
                                              scale: song["liked"] ? 1.2 : 1.0,
                                              duration: const Duration(milliseconds: 200),
                                              child: Icon(
                                                song["liked"]
                                                    ? Icons.favorite_rounded
                                                    : Icons.favorite_border_rounded,
                                                color: song["liked"]
                                                    ? Colors.pinkAccent
                                                    : Colors.white70,
                                              ),
                                            ),
                                          ),
                                          ValueListenableBuilder<bool>(
                                            valueListenable: audioController
                                                .isPlayingNotifier,
                                            builder:
                                                (context, isPlaying, child) {
                                              return IconButton(
                                                onPressed: () {
                                                  audioController.setPlaylist(
                                                    songs,
                                                  );
                                                  audioController.playSong(
                                                    song["audio"],
                                                    index,
                                                  );
                                                },
                                                icon: Icon(
                                                  isCurrent && isPlaying
                                                      ? Icons
                                                          .pause_circle_filled_rounded
                                                      : Icons
                                                          .play_circle_fill_rounded,
                                                  size: 30,
                                                  color: isCurrent
                                                      ? const Color(0xffA78BFA)
                                                      : Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            childCount: songs.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: audioController.isMiniPlayerVisible,
                  builder: (context, visible, child) {
                    return AnimatedSlide(
                      offset: visible ? Offset.zero : const Offset(0, 1),
                      duration: const Duration(milliseconds: 300),
                      child: visible ? MiniPlayer(controller: audioController) : const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}