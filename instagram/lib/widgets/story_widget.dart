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
                  // Show story inline with progress bars visible
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.8),
                    builder: (ctx) => StoryViewerDialog(
                      stories: widget.stories,
                      initialIndex: index,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
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
                    const SizedBox(height: 4),
                    Text(
                      ["we", "are", "partner", "in", "crime"][index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
  final List<String> storyCaptions = [
    "Not a lovers but worst.",
    'Harper said, "I love you but in a different way."',
    "Jay is definition perfect in perfection.",
    "Maybe in another life, i love you is not only a phrase but a promise.",
    "Crime doesn't pay, but we do"
  ];
  final Duration storyDuration = const Duration(seconds: 15);

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
    // Make sure the first story fades in
    storyTransitionController.forward();
  }

  void _startCurrentStory() {
    // Stop/cleanup any previous controller to prevent multiple completions firing
    for (var i = 0; i < progressControllers.length; i++) {
      if (i != currentIndex) {
        progressControllers[i].stop();
        progressControllers[i].removeListener(_updateProgress);
        progressControllers[i].reset();
        progressValues[i] = 0.0;
      }
    }

    progressControllers[currentIndex].removeListener(_updateProgress);
    progressControllers[currentIndex].addListener(_updateProgress);
    progressControllers[currentIndex].reset();

    progressControllers[currentIndex].forward().then((_) {
      if (!mounted) return;
      if (currentIndex < widget.stories.length - 1) {
        _nextStory();
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  void _updateProgress() {
    setState(() {
      progressValues[currentIndex] = progressControllers[currentIndex].value;
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
      child: SizedBox.expand(
        child: Stack(
          children: [
            // Full-screen story image
            Positioned.fill(
              child: FadeTransition(
                opacity: storyOpacity,
                child: SlideTransition(
                  position: storySlide,
                  child: Image.asset(
                    widget.stories[currentIndex],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),

            // Top overlays (progress bars and header)
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
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
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'images/tele20.jpg', // xeno_foster profile image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'xeno_foster',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 16,
                        ),
                        const Spacer(),
                        Text(
                          '${currentIndex + 1}/${widget.stories.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                ],
              ),
            ),

            // Tap anywhere to go to next story
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _onTapRight,
                child: const SizedBox.expand(),
              ),
            ),

            // Optional left area for previous story (tap in left 25%)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _onTapLeft,
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),

            // Optional right area for next story (tap in right 25%)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _onTapRight,
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),

            // Close button (positioned at top right, above all gestures)
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
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

            // Bottom caption + action buttons
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      storyCaptions[currentIndex],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
