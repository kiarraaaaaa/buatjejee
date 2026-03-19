import 'package:flutter/material.dart';
import '../controller/audio_controller.dart';
import '../data/lyrics_data.dart';

class LyricLine {
  final Duration time;
  final String text;

  LyricLine(this.time, this.text);
}

class NowPlayingScreen extends StatefulWidget {
  final dynamic song;
  final AudioController controller;

  const NowPlayingScreen({
    super.key,
    required this.song,
    required this.controller,
  });

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _rotation;

  @override
  void initState() {
    super.initState();

    _rotation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _rotation.dispose();
    super.dispose();
  }

  List<LyricLine> getLyrics(String title) {
    final key = title.toLowerCase();
    return lyricsData[key] ??
        [LyricLine(Duration(seconds: 1), "No lyrics available")];
  }

  int getCurrentIndex(List<LyricLine> lyrics, Duration position) {
    int index = lyrics.lastIndexWhere((l) => l.time <= position);
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.controller.currentSongNotifier,
      builder: (context, _, __) {

        final song = widget.controller.currentSong;

        final title = (song?["title"] ?? "").toString();
        final artist = (song?["artist"] ?? "").toString();
        final image = (song?["image"] ?? "").toString();

        final lyrics = getLyrics(title);

        return Scaffold(
          body: Stack(
            children: [

              /// BACKGROUND
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.grey.shade900,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              /// BLUR IMAGE
              Positioned.fill(
                child: Opacity(
                  opacity: 0.15,
                  child: image.isNotEmpty
                      ? Image.asset(image, fit: BoxFit.cover)
                      : Container(),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [

                    /// HEADER
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.white),
                        ),
                        const Text("Now Playing",
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(width: 48),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// COVER
                    RotationTransition(
                      turns: _rotation,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: image.isNotEmpty
                              ? Image.asset(image,
                                  fit: BoxFit.cover)
                              : Container(color: Colors.grey),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      artist,
                      style:
                          const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    /// 🎤 LYRICS (INI DOANG YANG DIGANTI)
                    Expanded(
                      child: ValueListenableBuilder<Duration>(
                        valueListenable:
                            widget.controller.currentPositionNotifier,
                        builder: (context, position, _) {

                          final currentIndex =
                              getCurrentIndex(lyrics, position);

                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: (child, animation) {
                              return ClipRect(
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.5),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              key: ValueKey(currentIndex),
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [

                                /// PREV
                                Text(
                                  currentIndex > 0
                                      ? lyrics[currentIndex - 1].text
                                      : "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                /// CURRENT
                                Text(
                                  lyrics[currentIndex].text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                /// NEXT
                                Text(
                                  currentIndex < lyrics.length - 1
                                      ? lyrics[currentIndex + 1].text
                                      : "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    /// PROGRESS (UNCHANGED)
                    ValueListenableBuilder<Duration>(
                      valueListenable:
                          widget.controller.currentPositionNotifier,
                      builder: (context, position, _) {
                        return ValueListenableBuilder<Duration>(
                          valueListenable:
                              widget.controller.totalDurationNotifier,
                          builder: (context, total, _) {

                            final progress =
                                total.inMilliseconds > 0
                                    ? position.inMilliseconds /
                                        total.inMilliseconds
                                    : 0.0;

                            return Column(
                              children: [

                                Slider(
                                  value:
                                      progress.clamp(0.0, 1.0),
                                  onChanged: (value) {
                                    final newPos =
                                        total.inMilliseconds *
                                            value;

                                    widget.controller.seek(
                                      Duration(
                                          milliseconds:
                                              newPos.toInt()),
                                    );
                                  },
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.grey,
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.controller
                                            .formatDuration(position),
                                        style: const TextStyle(
                                            color: Colors.white60),
                                      ),
                                      Text(
                                        widget.controller
                                            .formatDuration(total),
                                        style: const TextStyle(
                                            color: Colors.white60),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    /// CONTROL (UNCHANGED)
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [

                        IconButton(
                          onPressed: () {
                            widget.controller.playbackModeNotifier
                                .value = PlaybackMode.shuffle;
                          },
                          icon: const Icon(Icons.shuffle,
                              color: Colors.white54),
                        ),

                        IconButton(
                          onPressed:
                              widget.controller.previousSong,
                          icon: const Icon(Icons.skip_previous,
                              color: Colors.white, size: 28),
                        ),

                        ValueListenableBuilder<bool>(
                          valueListenable:
                              widget.controller.isPlayingNotifier,
                          builder: (context, isPlaying, _) {
                            return GestureDetector(
                              onTap: widget.controller
                                  .togglePlayPause,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                padding:
                                    const EdgeInsets.all(12),
                                child: Icon(
                                  isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.black,
                                  size: 26,
                                ),
                              ),
                            );
                          },
                        ),

                        IconButton(
                          onPressed:
                              widget.controller.nextSong,
                          icon: const Icon(Icons.skip_next,
                              color: Colors.white, size: 28),
                        ),

                        IconButton(
                          onPressed: () {
                            widget.controller.playbackModeNotifier
                                .value = PlaybackMode.repeat;
                          },
                          icon: const Icon(Icons.repeat,
                              color: Colors.white54),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
