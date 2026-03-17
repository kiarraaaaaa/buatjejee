import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum PlaybackMode { normal, repeat, shuffle }

class AudioController {
  AudioController._internal();
  static final AudioController _instance = AudioController._internal();
  factory AudioController() => _instance;

  final AudioPlayer _player = AudioPlayer();

  final ValueNotifier<int> currentSongNotifier = ValueNotifier<int>(-1);
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<Duration> currentPositionNotifier =
      ValueNotifier<Duration>(Duration.zero);
  final ValueNotifier<Duration> totalDurationNotifier =
      ValueNotifier<Duration>(Duration.zero);
  final ValueNotifier<bool> isMiniPlayerVisible = ValueNotifier<bool>(false);
  final ValueNotifier<PlaybackMode> playbackModeNotifier = ValueNotifier<PlaybackMode>(PlaybackMode.normal);

  // Shared visualizer controller
  late AnimationController visualizerController;
  late List<double> visualizerPhases;

  List<Map<String, dynamic>> _playlist = [];
  int _currentIndex = -1;
  bool _isInitialized = false;
  bool _isTransitioning = false;

  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    _player.processingStateStream.listen((processingState) {
      debugPrint("Processing state: $processingState");
      
      if (processingState == ProcessingState.completed) {
        debugPrint("Song completed, calling nextSong");
        nextSong();
      }
    });

    _player.playerStateStream.listen((state) {
      debugPrint("Player state: ${state.processingState}, playing: ${state.playing}");
      isPlayingNotifier.value = state.playing;
    });

    _player.positionStream.listen((position) {
      currentPositionNotifier.value = position;
      
      // Check if song is near completion (within 1 second of end)
      final duration = totalDurationNotifier.value;
      if (duration.inMilliseconds > 0 && 
          position.inMilliseconds >= duration.inMilliseconds - 1000 &&
          _currentIndex >= 0 &&
          !_isTransitioning) {
        debugPrint("Song near completion, position: $position, duration: $duration");
        _isTransitioning = true;
        debugPrint("Calling nextSong due to position check");
        nextSong().then((_) {
          _isTransitioning = false;
        });
      }
    });

    _player.durationStream.listen((duration) {
      if (duration != null) {
        totalDurationNotifier.value = duration;
      }
    });
  }

  void initVisualizer(TickerProvider vsync) {
    visualizerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: vsync,
    );

    visualizerPhases = List.generate(4, (index) => (index + 1) * 1.2);

    isPlayingNotifier.addListener(_updateVisualizer);
    _updateVisualizer();
  }

  void _updateVisualizer() {
    if (isPlayingNotifier.value) {
      if (!visualizerController.isAnimating) {
        visualizerController.repeat();
      }
    } else {
      visualizerController.stop();
      visualizerController.value = 0.0;
    }
  }

  double computeBarFactor(int index) {
    final phase = visualizerPhases[index];
    final t = visualizerController.value * 2 * pi;
    final normalized = (sin(t + phase) + 1) / 2;
    return 0.35 + (normalized * 0.65);
  }

  void setPlaylist(List<Map<String, dynamic>> songs) {
    _playlist = songs;
  }

  List<Map<String, dynamic>> get playlist => _playlist;

  int get currentIndex => _currentIndex;

  Map<String, dynamic>? get currentSong {
    if (_currentIndex < 0 || _currentIndex >= _playlist.length) {
      return null;
    }
    return _playlist[_currentIndex];
  }

  Future<void> playSong(String path, int index) async {
    await init();

    try {
      debugPrint("playSong called with path: $path, index: $index");
      if (_playlist.isEmpty) {
        debugPrint("Playlist is empty");
        return;
      }
      if (index < 0 || index >= _playlist.length) {
        debugPrint("Invalid index: $index");
        return;
      }

      if (_currentIndex == index) {
        debugPrint("Same song, toggling play/pause");
        await togglePlayPause();
        return;
      }

      _currentIndex = index;
      currentSongNotifier.value = index;
      isMiniPlayerVisible.value = true;
      currentPositionNotifier.value = Duration.zero;
      totalDurationNotifier.value = Duration.zero;
      _isTransitioning = false;

      debugPrint("Stopping current playback");
      await _player.stop();

      debugPrint("Setting audio source: $path");

      await _player.setAudioSource(AudioSource.asset(path));
      debugPrint("Audio source set successfully, starting playback");
      await _player.play();

      isPlayingNotifier.value = true;
      debugPrint("Playback started successfully");
    } catch (e, stackTrace) {
      debugPrint("Error in playSong: $e");
      debugPrint("Stack trace: $stackTrace");
    }
  }

  Future<void> togglePlayPause() async {
    // If no song is selected yet, start the first song in the playlist.
    if (_currentIndex == -1 && _playlist.isNotEmpty) {
      await playSong(_playlist[0]["audio"], 0);
      return;
    }

    // Use the player's actual state to avoid staleness from notifier lag.
    if (_player.playing) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
      isPlayingNotifier.value = false;
    } catch (e) {
      debugPrint("Error pause: $e");
    }
  }

  Future<void> resume() async {
    try {
      if (_currentIndex == -1) return;
      await _player.play();
      isPlayingNotifier.value = true;
    } catch (e) {
      debugPrint("Error resume: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
      _currentIndex = -1;
      currentSongNotifier.value = -1;
      isPlayingNotifier.value = false;
      currentPositionNotifier.value = Duration.zero;
      totalDurationNotifier.value = Duration.zero;
      isMiniPlayerVisible.value = false;
    } catch (e) {
      debugPrint("Error stop: $e");
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e) {
      debugPrint("Error seek: $e");
    }
  }

  Future<void> nextSong() async {
    debugPrint("nextSong called, playlist length: ${_playlist.length}, currentIndex: $_currentIndex, mode: ${playbackModeNotifier.value}");
    if (_playlist.isEmpty) {
      debugPrint("Playlist is empty, cannot play next song");
      return;
    }

    switch (playbackModeNotifier.value) {
      case PlaybackMode.repeat:
        debugPrint("Repeat mode: replaying current song");
        await playSong(_playlist[_currentIndex]["audio"], _currentIndex);
        break;
      case PlaybackMode.shuffle:
        debugPrint("Shuffle mode: selecting random song");
        final random = Random();
        int randomIndex;
        do {
          randomIndex = random.nextInt(_playlist.length);
        } while (_playlist.length > 1 && randomIndex == _currentIndex);
        debugPrint("Selected random index: $randomIndex");
        await playSong(_playlist[randomIndex]["audio"], randomIndex);
        break;
      case PlaybackMode.normal:
        debugPrint("Normal mode: playing next sequential song");
        int nextIndex = _currentIndex + 1;
        if (nextIndex >= _playlist.length) {
          nextIndex = 0;
          debugPrint("Reached end of playlist, looping to first song");
        }
        debugPrint("Next index: $nextIndex");
        await playSong(_playlist[nextIndex]["audio"], nextIndex);
        break;
    }
  }

  void togglePlaybackMode() {
    switch (playbackModeNotifier.value) {
      case PlaybackMode.normal:
        playbackModeNotifier.value = PlaybackMode.repeat;
        break;
      case PlaybackMode.repeat:
        playbackModeNotifier.value = PlaybackMode.shuffle;
        break;
      case PlaybackMode.shuffle:
        playbackModeNotifier.value = PlaybackMode.normal;
        break;
    }
  }

  Future<void> previousSong() async {
    if (_playlist.isEmpty) return;

    if (currentPositionNotifier.value.inSeconds > 3) {
      await seek(Duration.zero);
      return;
    }

    int prevIndex = _currentIndex - 1;
    if (prevIndex < 0) prevIndex = _playlist.length - 1;

    await playSong(_playlist[prevIndex]["audio"], prevIndex);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = duration.inHours;
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (hours > 0) {
      return "${twoDigits(hours)}:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }

  Future<void> disposePlayer() async {
    await _player.dispose();
  }
}