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
  late AnimationController _visualizerController;
  late List<double> _visualizerPhases;

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
          margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xff1a1a1a),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<Duration>(
                valueListenable: widget.controller.currentPositionNotifier,
                builder: (context, position, child) {
                  return ValueListenableBuilder<Duration>(
                    valueListenable: widget.controller.totalDurationNotifier,
                    builder: (context, duration, child) {
                      double progress = 0;

                      if (duration.inMilliseconds > 0) {
                        progress =
                            position.inMilliseconds / duration.inMilliseconds;
                        progress = progress.clamp(0.0, 1.0);
                      }

                      return Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 5,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 10,
                              ),
                            ),
                            child: Slider(
                              value: progress,
                              onChanged: (value) {
                                final newPosition = Duration(
                                  milliseconds:
                                      (duration.inMilliseconds * value).toInt(),
                                );
                                widget.controller.seek(newPosition);
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.controller.formatDuration(position),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  widget.controller.formatDuration(duration),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11,
                                  ),
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
              const SizedBox(height: 4),
              Row(
                children: [
                  // Album art with music visualizer
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          song["image"],
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (widget.controller.isPlayingNotifier.value)
                        Positioned.fill(
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(4, (index) {
                                return AnimatedBuilder(
                                  animation: widget.controller.visualizerController,
                                  builder: (context, child) {
                                    return Container(
                                      width: 3,
                                      height: 10 + (20 * widget.controller.computeBarFactor(index)),
                                      margin: const EdgeInsets.symmetric(horizontal: 1),
                                      decoration: BoxDecoration(
                                        color: Colors.pinkAccent,
                                        borderRadius: BorderRadius.circular(1.5),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song["title"] ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          song["artist"] ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 0.8).animate(
                      CurvedAnimation(parent: _prevButtonController, curve: Curves.easeInOut),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _animateTap(_prevButtonController, _isAnimatingPrev, (bool value) => setState(() => _isAnimatingPrev = value));
                        widget.controller.previousSong();
                      },
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 0.9).animate(
                      CurvedAnimation(parent: _playButtonController, curve: Curves.easeInOut),
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: widget.controller.isPlayingNotifier,
                      builder: (context, isPlaying, child) {
                        return IconButton(
                          onPressed: () {
                            _animateTap(_playButtonController, _isAnimatingPlay, (bool value) => setState(() => _isAnimatingPlay = value));
                            widget.controller.togglePlayPause();
                          },
                          icon: Icon(
                            isPlaying
                                ? Icons.pause_circle_filled_rounded
                                : Icons.play_circle_fill_rounded,
                            color: Colors.white,
                            size: 34,
                          ),
                        );
                      },
                    ),
                  ),
                  ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 0.8).animate(
                      CurvedAnimation(parent: _nextButtonController, curve: Curves.easeInOut),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _animateTap(_nextButtonController, _isAnimatingNext, (bool value) => setState(() => _isAnimatingNext = value));
                        widget.controller.nextSong();
                      },
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ValueListenableBuilder<PlaybackMode>(
                      valueListenable: widget.controller.playbackModeNotifier,
                      builder: (context, mode, child) {
                        return DropdownButton<PlaybackMode>(
                          value: mode,
                          dropdownColor: const Color(0xff1a1a1a),
                          underline: const SizedBox.shrink(),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white70, size: 16),
                          items: [
                            DropdownMenuItem(
                              value: PlaybackMode.normal,
                              child: Row(
                                children: [
                                  Icon(Icons.repeat_one_rounded, color: Colors.white70, size: 16),
                                  const SizedBox(width: 4),
                                  const Text('Normal', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: PlaybackMode.repeat,
                              child: Row(
                                children: [
                                  Icon(Icons.repeat_rounded, color: Colors.pinkAccent, size: 16),
                                  const SizedBox(width: 4),
                                  const Text('Repeat', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: PlaybackMode.shuffle,
                              child: Row(
                                children: [
                                  Icon(Icons.shuffle_rounded, color: Colors.greenAccent, size: 16),
                                  const SizedBox(width: 4),
                                  const Text('Shuffle', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (PlaybackMode? newMode) {
                            if (newMode != null) {
                              widget.controller.playbackModeNotifier.value = newMode;
                            }
                          },
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: widget.controller.stop,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

