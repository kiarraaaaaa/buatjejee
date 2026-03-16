import 'package:flutter/material.dart';
import '../controller/audio_controller.dart';

class MiniPlayer extends StatelessWidget {
const MiniPlayer({super.key});

@override
Widget build(BuildContext context) {

final controller = AudioController.instance;

return ValueListenableBuilder(
  valueListenable: controller.currentIndex,
  builder: (context, index, _) {

    if (index == -1) return const SizedBox();

    var song = controller.songs[index];

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: const Border(
          top: BorderSide(color: Colors.white12)
        )
      ),

      child: Row(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              song["image"],
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
                  song["title"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  song["artist"],
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            ),
          ),

          ValueListenableBuilder(
            valueListenable: controller.isPlaying,
            builder: (context, playing, _) {

              return IconButton(
                icon: Icon(
                  playing ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  playing
                      ? controller.pause()
                      : controller.resume();
                },
              );

            },
          ),

          IconButton(
            icon: const Icon(Icons.skip_next, color: Colors.white),
            onPressed: () {
              controller.next();
            },
          )

        ],
      ),
    );
  },
);

}
}
