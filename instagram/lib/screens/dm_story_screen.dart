import 'package:flutter/material.dart';

class Chapter {
  final String label;
  final String title;
  final List<String> paragraphs;

  const Chapter({
    required this.label,
    required this.title,
    required this.paragraphs,
  });
}

class DmStoryScreen extends StatefulWidget {
  const DmStoryScreen({super.key});

  @override
  State<DmStoryScreen> createState() => _DmStoryScreenState();
}

class _DmStoryScreenState extends State<DmStoryScreen> with SingleTickerProviderStateMixin {
  static const List<Chapter> _chapters = [
    Chapter(
      label: 'Chapter 1',
      title: 'First Impression',
      paragraphs: [
        'The world was far too boring. Nothing ever managed to interest Xeno; everything seemed ordinary, predictable, and painfully normal. Graduation had finally come, and it was time for Xeno to move to his new school.',
        'There, he found himself surrounded by a completely new environment. Many people were curious about him and instantly drawn to him the moment he stepped into the school. But everything seemed to stop the moment Xeno entered his classroom and noticed someone different from everyone else.',
        'He was handsome and undeniably attractive. He spoke enthusiastically with his friends, his energy filling the room effortlessly.',
        'Xeno chose to sit quietly by himself, but without realizing it, the person who had caught his attention ended up sitting right beside him. They became seatmates.',
        '“Hey, my name is Harper.”',
        'Xeno gave no response.',
        '“You’re Xeno, right? A lot of people know you because of your personality and your looks. Many people are interested in you.”',
        'Xeno looked directly into Harper’s eyes, his blue gaze fixed on him.',
        '“You too?”',
        'The question instantly turned the atmosphere silent. Harper laughed softly, trying to break the awkward tension.',
        '“I think being friends with you is going to be really interesting, Xeno Foster.”',
        'Everything went on as usual after that. Harper introduced Xeno to his circle of friends: Nda, Angel, Drake, Lullaby, and Artemis. They even planned to recruit him into the student council.',
        'During their first term, Drake served as the student council president, while Xeno became the vice president because he was the one who often handled Drake’s responsibilities. In a way, he was Drake’s right-hand man.',
        'Things went smoothly. Being part of the student council world made Xeno no longer feel lonely.',
        'It was all thanks to Harper.',
        'Was Xeno interested in Harper?',
        'Not yet.',
        'He only communicated with Harper and the others for student council matters—nothing more.',
        'Until eventually, everything changed when Harper no longer seemed okay.',
      ],
    ),
    Chapter(
      label: 'Chapter 2',
      title: 'New Beginnings',
      paragraphs: [
        'Chapter 2 is being prepared. The story will continue with Xeno’s first real school day, the new people he meets, and the first quiet moments when Harper’s presence begins to matter more.',
        'This next part will explore how Xeno adjusts to the student council and how his friendship with Harper changes from distant curiosity into something more meaningful.',
      ],
    ),
    Chapter(
      label: 'Chapter 3',
      title: 'Unsettled Feelings',
      paragraphs: [
        'Chapter 3 is coming soon. It will show the first time Xeno notices the tension in Harper’s smile and the subtle shift that makes everything feel less ordinary again.',
      ],
    ),
  ];

  int _selectedChapterIndex = 0;
  late final AnimationController _animationController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );

    _fade = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectChapter(int index) {
    setState(() {
      _selectedChapterIndex = index;
    });
  }

  void _showNextChapter() {
    if (_selectedChapterIndex < _chapters.length - 1) {
      _selectChapter(_selectedChapterIndex + 1);
    }
  }

  void _showPreviousChapter() {
    if (_selectedChapterIndex > 0) {
      _selectChapter(_selectedChapterIndex - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chapter = _chapters[_selectedChapterIndex];
    final storyText = chapter.paragraphs.join('\n\n');

    return Scaffold(
      backgroundColor: const Color(0xFF06060D),
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [
                    Color(0xFF090913),
                    Color(0xFF0D0D16),
                    Color(0xFF0B0B14),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -100,
            left: -120,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3F3BFF).withAlpha(46),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00D4FF).withAlpha(31),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: FadeTransition(
                    opacity: _fade,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF11131F),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage('images/tele24.jpg'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'DUO PUNCAK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1D2140),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF111823),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: const Text(
                                      'Storyline',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFF11131F),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.send_rounded, color: Colors.white70, size: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _fade,
                  child: SizeTransition(
                    sizeFactor: _fade,
                    axisAlignment: -1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF11131F).withAlpha(240),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(61),
                              blurRadius: 24,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B1D2A),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.book_rounded,
                                size: 22,
                                color: Color(0xFF69E2FF),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Chapter Journey',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Tap a chapter to jump into the next part of the story.',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: SlideTransition(
                    position: _slide,
                    child: FadeTransition(
                      opacity: _fade,
                      child: SizedBox(
                        height: 52,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _chapters.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final isSelected = index == _selectedChapterIndex;
                            return GestureDetector(
                              onTap: () => _selectChapter(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 240),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF363D7A) : const Color(0xFF11131F),
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF69E2FF) : Colors.white12,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    _chapters[index].label,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.white54,
                                      fontSize: 13,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 280),
                      child: SingleChildScrollView(
                        key: ValueKey(_selectedChapterIndex),
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF11131F),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${chapter.label}. ${chapter.title}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                storyText,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  height: 1.8,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _selectedChapterIndex > 0 ? _showPreviousChapter : null,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: _selectedChapterIndex > 0 ? const Color(0xFF69E2FF) : Colors.white12,
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF11131F),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Previous'),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _selectedChapterIndex < _chapters.length - 1 ? _showNextChapter : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF69E2FF),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Next'),
                        ),
                      ),
                    ],
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
