import 'package:flutter/material.dart';

class SwipeHintWidget extends StatelessWidget {
  const SwipeHintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1500),
        onEnd: () {
          // Animation complete - could trigger repeat if needed
        },
        builder: (context, value, child) {
          // Create pulsing effect using value
          return Opacity(
            opacity: value < 0.5 ? value * 2 : 2 - (value * 2),
            child: Transform.translate(
              offset: Offset(value * 0.3, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.swipe_left,
                    color: Colors.white.withAlpha(150),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Swipe to explore',
                    style: TextStyle(
                      color: Colors.white.withAlpha(150),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
