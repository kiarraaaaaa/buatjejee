import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class LikesScreen extends StatefulWidget {
const LikesScreen({super.key});

@override
State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {

final AudioPlayer player = AudioPlayer();

int currentSongIndex = -1;
Duration position = Duration.zero;
Duration duration = Duration.zero;
bool isPlaying = false;

List<Map<String, dynamic>> songs = [
{
"title": "Him and I",
"artist": "G-Eazy & Halsey",
"image": "images/tele11.jpg",
"audio": "audio/HimandI.mp3",
"liked": false
},
{
"title": "Party 4 U",
"artist": "Charli XCX",
"image": "images/tele9.jpg",
"audio": "audio/Party.mp3",
"liked": false
},
{
"title": "Rock That Body x Outside",
"artist": "Nightdrives",
"image": "images/tele8.jpg",
"audio": "audio/Rock.mp3",
"liked": false
},
{
"title": "Fetish",
"artist": "Selena Gomez ft. Gucci Mane",
"image": "images/tele10.jpg",
"audio": "audio/Fetish.mp3",
"liked": false
},
{
"title": "Again",
"artist": "Noah Cyrus",
"image": "images/tele7.jpg",
"audio": "audio/Again.mp3",
"liked": false
},
{
"title": "Flatline",
"artist": "Justin Bieber",
"image": "images/tele6.jpg",
"audio": "audio/flatline.mp3",
"liked": false
},
{
"title": "Shameless",
"artist": "Camilla Cabello",
"image": "images/tele12.jpg",
"audio": "audio/Shameless.mp3",
"liked": false
},
{
"title": "Boyfriend",
"artist": "Justin Bieber",
"image": "images/tele13.jpg",
"audio": "audio/Boyfriend.mp3",
"liked": false
},
{
"title": "The Fate of Ophelia",
"artist": "Taylor Swift",
"image": "images/tele14.jpg",
"audio": "audio/Ophelia.mp3",
"liked": false
},
{
"title": "The Man Who Can't Be Moved",
"artist": "The Script",
"image": "images/tele15.jpg",
"audio": "audio/TheMan.mp3",
"liked": false
},
];

@override
void initState() {
super.initState();

player.positionStream.listen((p) {
  setState(() {
    position = p;
  });
});

player.durationStream.listen((d) {
  if (d != null) {
    setState(() {
      duration = d;
    });
  }
});

player.playerStateStream.listen((state) {
  setState(() {
    isPlaying = state.playing;
  });
});

}

Future<void> playSong(String path, int index) async {
try {
await player.stop();
await player.setAsset(path);
player.play();

  setState(() {
    currentSongIndex = index;
  });
} catch (e) {
  print(e);
}

}

void nextSong() {
if (currentSongIndex < songs.length - 1) {
playSong(songs[currentSongIndex + 1]["audio"], currentSongIndex + 1);
}
}

String formatTime(Duration d) {
String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
return "$minutes:$seconds";
}

@override
void dispose() {
player.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {

return Scaffold(
  backgroundColor: Colors.black,

  body: SafeArea(
    child: Column(
      children: [

        Expanded(
          child: ListView(
            children: [

              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "images/tele1.jpg",
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Ride or Die",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Top Songs That Suit You So Much",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: () {
                        playSong(songs[0]["audio"], 0);
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Play Playlist"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: Colors.white24),

              ...songs.asMap().entries.map((entry) {

                int index = entry.key;
                var song = entry.value;

                return ListTile(
                  onTap: () {
                    playSong(song["audio"], index);
                  },

                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      song["image"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),

                  title: Text(
                    song["title"],
                    style: const TextStyle(color: Colors.white),
                  ),

                  subtitle: Text(
                    song["artist"],
                    style: const TextStyle(color: Colors.white54),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      IconButton(
                        icon: Icon(
                          song["liked"]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: song["liked"]
                              ? Colors.red
                              : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            song["liked"] = !song["liked"];
                          });
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        onPressed: () {
                          playSong(song["audio"], index);
                        },
                      ),

                    ],
                  ),
                );

              }).toList(),
            ],
          ),
        ),

        if (currentSongIndex != -1)
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF121212),
              border: Border(
                top: BorderSide(color: Colors.white12),
              ),
            ),

            child: Row(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    songs[currentSongIndex]["image"],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        songs[currentSongIndex]["title"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        songs[currentSongIndex]["artist"],
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  ),
                ),

                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (isPlaying) {
                      player.pause();
                    } else {
                      player.play();
                    }
                  },
                ),

                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.white),
                  onPressed: nextSong,
                ),

              ],
            ),
          ),
      ],
    ),
  ),
);

}
}
