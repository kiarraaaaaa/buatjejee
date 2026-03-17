import 'package:flutter/material.dart';
import '../controller/audio_controller.dart';

class MiniPlayer extends StatefulWidget {
  final AudioController controller;

  const MiniPlayer({
    super.key,
    required this.controller,
  });

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> with TickerProviderStateMixin {
  late AnimationController _playButtonController;
  late AnimationController _nextButtonController;
  late AnimationController _prevButtonController;

  bool _isAnimatingPlay = false;
  bool _isAnimatingNext = false;
  bool _isAnimatingPrev = false;

  @override
  void initState() {
    super.initState();

    _playButtonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _nextButtonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _prevButtonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Initialize shared visualizer
    widget.controller.initVisualizer(this);
  }

  void _animateTap(AnimationController controller, bool isAnimating, Function setAnimating) {
    if (isAnimating || controller.isAnimating) return;
    setAnimating(true);
    controller.forward(from: 0).then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          controller.reverse().then((_) {
            if (mounted) setAnimating(false);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _playButtonController.dispose();
    _nextButtonController.dispose();
    _prevButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.controller.currentSongNotifier,
      builder: (context, currentIndex, child) {
        final song = widget.controller.currentSong;

        if (song == null || currentIndex == -1) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.fromLTRB(6, 0, 6, 6),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xff1a1a1a),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Album art
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  song["image"],
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              // Song title and artist
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song["title"] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      song["artist"] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Control buttons - centered
              SizedBox(
                height: 36,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: Tween<double>(begin: 1.0, end: 0.8).animate(
                        CurvedAnimation(parent: _prevButtonController, curve: Curves.easeInOut),
                      ),
                      child: SizedBox(
                        width: 34,
                        height: 36,
                        child: IconButton(
                          onPressed: () {
                            _animateTap(_prevButtonController, _isAnimatingPrev, (bool value) => setState(() => _isAnimatingPrev = value));
                            widget.controller.previousSong();
                          },
                          icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 20),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ),
                    ScaleTransition(
                      scale: Tween<double>(begin: 1.0, end: 0.9).animate(
                        CurvedAnimation(parent: _playButtonController, curve: Curves.easeInOut),
                      ),
                      child: SizedBox(
                        width: 34,
                        height: 36,
                        child: ValueListenableBuilder<bool>(
                          valueListenable: widget.controller.isPlayingNotifier,
                          builder: (context, isPlaying, child) {
                            return IconButton(
                              onPressed: () {
                                _animateTap(_playButtonController, _isAnimatingPlay, (bool value) => setState(() => _isAnimatingPlay = value));
                                widget.controller.togglePlayPause();
                              },
                              icon: Icon(
                                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            );
                          },
                        ),
                      ),
                    ),
                    ScaleTransition(
                      scale: Tween<double>(begin: 1.0, end: 0.8).animate(
                        CurvedAnimation(parent: _nextButtonController, curve: Curves.easeInOut),
                      ),
                      child: SizedBox(
                        width: 34,
                        height: 36,
                        child: IconButton(
                          onPressed: () {
                            _animateTap(_nextButtonController, _isAnimatingNext, (bool value) => setState(() => _isAnimatingNext = value));
                            widget.controller.nextSong();
                          },
                          icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 20),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Mode selector
              ValueListenableBuilder<PlaybackMode>(
                valueListenable: widget.controller.playbackModeNotifier,
                builder: (context, mode, child) {
                  IconData icon;
                  Color iconColor;
                  switch (mode) {
                    case PlaybackMode.repeat:
                      icon = Icons.repeat_rounded;
                      iconColor = Colors.pinkAccent;
                      break;
                    case PlaybackMode.shuffle:
                      icon = Icons.shuffle_rounded;
                      iconColor = Colors.greenAccent;
                      break;
                    case PlaybackMode.normal:
                    default:
                      icon = Icons.repeat_one_rounded;
                      iconColor = Colors.white70;
                      break;
                  }

                  return PopupMenuButton<PlaybackMode>(
                    padding: EdgeInsets.zero,
                    color: const Color(0xff1a1a1a),
                    tooltip: 'Playback mode',
                    icon: Icon(icon, color: iconColor, size: 18),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: PlaybackMode.normal,
                        child: Row(
                          children: const [
                            Icon(Icons.repeat_one_rounded, color: Colors.white70, size: 16),
                            SizedBox(width: 8),
                            Text('Normal', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: PlaybackMode.repeat,
                        child: Row(
                          children: const [
                            Icon(Icons.repeat_rounded, color: Colors.pinkAccent, size: 16),
                            SizedBox(width: 8),
                            Text('Repeat', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: PlaybackMode.shuffle,
                        child: Row(
                          children: const [
                            Icon(Icons.shuffle_rounded, color: Colors.greenAccent, size: 16),
                            SizedBox(width: 8),
                            Text('Shuffle', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (PlaybackMode newMode) {
                      widget.controller.playbackModeNotifier.value = newMode;
                    },
                  );
                },
              ),
              const SizedBox(width: 6),
              // Close button
              SizedBox(
                width: 26,
                height: 26,
                child: IconButton(
                  onPressed: widget.controller.stop,
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 14),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ValueListenableBuilder<Duration>(
            valueListenable: widget.controller.currentPositionNotifier,
            builder: (context, position, child) {
              return ValueListenableBuilder<Duration>(
                valueListenable: widget.controller.totalDurationNotifier,
                builder: (context, total, child) {
                  final progress = total.inMilliseconds > 0
                      ? position.inMilliseconds / total.inMilliseconds
                      : 0.0;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                        minHeight: 2,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.controller.formatDuration(position),
                            style: const TextStyle(color: Colors.white60, fontSize: 10),
                          ),
                          Text(
                            widget.controller.formatDuration(total),
                            style: const TextStyle(color: Colors.white60, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  },
);
}
}

