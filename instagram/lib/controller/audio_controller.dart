import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class AudioController {

static final AudioController instance = AudioController._internal();

factory AudioController() {
return instance;
}

AudioController._internal();

final AudioPlayer player = AudioPlayer();

ValueNotifier<int> currentIndex = ValueNotifier(-1);
ValueNotifier<bool> isPlaying = ValueNotifier(false);

List<Map<String, dynamic>> songs = [];

void setPlaylist(List<Map<String, dynamic>> list) {
songs = list;
}

Future<void> playSong(int index) async {
if (songs.isEmpty) return;

await player.setAsset(songs[index]["audio"]);
player.play();

currentIndex.value = index;
isPlaying.value = true;

}

void pause() {
player.pause();
isPlaying.value = false;
}

void resume() {
player.play();
isPlaying.value = true;
}

void next() {
if (currentIndex.value < songs.length - 1) {
playSong(currentIndex.value + 1);
}
}

}
