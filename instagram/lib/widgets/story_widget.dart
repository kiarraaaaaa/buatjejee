import 'package:flutter/material.dart';

class StoryWidget extends StatefulWidget {
  final List<String> stories;

  const StoryWidget({
    super.key,
    required this.stories,
  });

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> with TickerProviderStateMixin {
  late List<AnimationController> _storyControllers;
  late List<Animation<double>> _storyAnimations;

  @override
  void initState() {
    super.initState();
    _storyControllers = List<AnimationController>.generate(
      widget.stories.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _storyAnimations = _storyControllers.asMap().entries.map((entry) {
      int index = entry.key;
      AnimationController controller = entry.value;

      return Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
    }).toList();

    // Staggered animation
    for (int i = 0; i < _storyControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted && i < _storyControllers.length) {
          _storyControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _storyControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: List.generate(
            widget.stories.length,
            (index) => ScaleTransition(
              scale: _storyAnimations[index],
              child: GestureDetector(
                onTap: () {
                  // Show story full screen with Instagram-like features
                  showDialog(
                    context: context,
                    builder: (ctx) => StoryViewerDialog(
                      stories: widget.stories,
                      initialIndex: index,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.withOpacity(0.6),
                        Colors.purple.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.stories[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StoryViewerDialog extends StatefulWidget {
  final List<String> stories;
  final int initialIndex;

  const StoryViewerDialog({
    super.key,
    required this.stories,
    required this.initialIndex,
  });

  @override
  State<StoryViewerDialog> createState() => _StoryViewerDialogState();
}

class _StoryViewerDialogState extends State<StoryViewerDialog>
    with TickerProviderStateMixin {
  late int currentIndex;
  late List<double> progressValues;
  late List<AnimationController> progressControllers;
  late AnimationController storyTransitionController;
  late Animation<double> storyOpacity;
  late Animation<Offset> storySlide;

  final List<String> storyNames = ["we", "are", "partner", "in", "crime"];
  final Duration storyDuration = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    progressValues = List<double>.filled(widget.stories.length, 0.0);

    progressControllers = List<AnimationController>.generate(
      widget.stories.length,
      (index) => AnimationController(
        duration: storyDuration,
        vsync: this,
      ),
    );

    storyTransitionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    storyOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: storyTransitionController, curve: Curves.easeIn),
    );

    storySlide = Tween<Offset>(
      begin: const Offset(0.2, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: storyTransitionController, curve: Curves.easeOut),
    );

    _startCurrentStory();
  }

  void _startCurrentStory() {
    progressControllers[currentIndex].forward().then((_) {
      if (currentIndex < widget.stories.length - 1) {
        _nextStory();
      } else {
        Navigator.of(context).pop();
      }
    });

    progressControllers[currentIndex].addListener(() {
      setState(() {
        progressValues[currentIndex] = progressControllers[currentIndex].value;
      });
    });
  }

  void _nextStory() {
    if (currentIndex < widget.stories.length - 1) {
      setState(() {
        currentIndex++;
      });
      storyTransitionController.reset();
      storyTransitionController.forward();
      _startCurrentStory();
    }
  }

  void _previousStory() {
    if (currentIndex > 0) {
      progressControllers[currentIndex].stop();
      setState(() {
        currentIndex--;
        progressValues[currentIndex] = 0.0;
      });
      storyTransitionController.reset();
      storyTransitionController.forward();
      progressControllers[currentIndex].reset();
      _startCurrentStory();
    }
  }

  void _onTapLeft() {
    _previousStory();
  }

  void _onTapRight() {
    if (currentIndex < widget.stories.length - 1) {
      _nextStory();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    for (var controller in progressControllers) {
      controller.dispose();
    }
    storyTransitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Progress bars
          Positioned(
            top: 12,
            left: 8,
            right: 8,
            child: Row(
              children: List.generate(
                widget.stories.length,
                (index) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 2,
                    child: LinearProgressIndicator(
                      value: index < currentIndex
                          ? 1.0
                          : index == currentIndex
                              ? progressValues[index]
                              : 0.0,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Story image with transition
          FadeTransition(
            opacity: storyOpacity,
            child: SlideTransition(
              position: storySlide,
              child: Container(
                color: Colors.black,
                child: Image.asset(
                  widget.stories[currentIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),

          // Story name
          Positioned(
            top: 40,
            left: 16,
            child: Text(
              storyNames[currentIndex],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),

          // Gesture areas for navigation
          Row(
            children: [
              // Left tap area
              Expanded(
                child: GestureDetector(
                  onTap: _onTapLeft,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              // Right tap area
              Expanded(
                child: GestureDetector(
                  onTap: _onTapRight,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),

          // Close button
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Bottom action buttons
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // Like functionality
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Comment functionality
                  },
                  icon: const Icon(
                    Icons.mode_comment_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Share functionality
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
