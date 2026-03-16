import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

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

  List<Map<String, dynamic>> _playlist = [];
  int _currentIndex = -1;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    _player.playerStateStream.listen((state) {
      isPlayingNotifier.value = state.playing;

      if (state.processingState == ProcessingState.completed) {
        nextSong();
      }
    });

    _player.positionStream.listen((position) {
      currentPositionNotifier.value = position;
    });

    _player.durationStream.listen((duration) {
      if (duration != null) {
        totalDurationNotifier.value = duration;
      }
    });
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
      if (_playlist.isEmpty) return;
      if (index < 0 || index >= _playlist.length) return;

      if (_currentIndex == index) {
        await togglePlayPause();
        return;
      }

      _currentIndex = index;
      currentSongNotifier.value = index;
      isMiniPlayerVisible.value = true;
      currentPositionNotifier.value = Duration.zero;
      totalDurationNotifier.value = Duration.zero;

      await _player.stop();

      debugPrint("Playing asset: $path");

      await _player.setAsset(path);
      await _player.play();

      isPlayingNotifier.value = true;
    } catch (e) {
      debugPrint("Error playSong: $e");
    }
  }

  Future<void> togglePlayPause() async {
    if (isPlayingNotifier.value) {
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
    if (_playlist.isEmpty) return;

    int nextIndex = _currentIndex + 1;
    if (nextIndex >= _playlist.length) nextIndex = 0;

    await playSong(_playlist[nextIndex]["audio"], nextIndex);
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