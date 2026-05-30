import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  static final List<Chapter> _chapters = [
    Chapter(
      label: 'Chapter 1',
      title: 'Who?',
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
      title: 'Curious but protective.',
      paragraphs: [
        'Something strange started happening.',
        'For some reason, several students began mocking Harper, bringing up a past he never wanted to hear about again. Some students strongly disagreed with him becoming a member of the student council.',
        'At first, Xeno did not care.',
        'But as the days passed, things only became worse. Rumors constantly haunted Harper. Everywhere he went, whispers followed him. The boy who used to smile so brightly now seemed afraid to even greet other students.',
        'Xeno watched everything from a distance. Quietly, he began searching for the truth himself. Things the other student council members apparently already knew—except for him.',
        'During one of the student council events, Harper looked nervous, almost hiding himself behind the others, unwilling to show his face. Then suddenly, someone grabbed his hand.',
        'It was Xeno.',
        'Without saying anything, Xeno guided Harper past the other students, almost as if he were shielding him from them. The hallway fell silent. Everyone stared, too shocked—and honestly, too intimidated—to say anything.',
        'Xeno did not care about the rumors surrounding Harper.',
        'When they finally reached an empty hallway, Harper harshly pulled his hand away from Xeno’s grip.',
        '“Why?” Harper asked quietly.',
        'What he really meant was: Why are you protecting me?',
        'Xeno did not answer immediately. Their eyes met in silence.',
        '“Because I finally found another reason to stay at this school.”',
        'If you truly understand those words, then you will understand what he really meant.',
        'Xeno, who once had no interest in friendship, no desire to care about school life, and no reason to involve himself with anyone, had suddenly become protective of Harper.',
        'And from that moment on, their relationship slowly grew closer.',
        'They started walking to the cafeteria together, talking for hours about LOOKISM, their favorite manhwa. Xeno never grew tired of listening to Harper’s stories, complaints, or even his frustrated grumbling. To him, Harper’s voice sounded almost like music.',
        'And perhaps some of you are still wondering—',
        'Why was Xeno so drawn to him?',
        'The truth was, he did not know either.',
        'His feelings simply told him that he had to protect this person because Harper was far too gentle for a world like this.',
        'At the very least, Xeno finally had a purpose at school now:',
        'To protect Harper.',
      ],
    ),
    Chapter(
      label: 'Chapter 3',
      title: 'Top Duo',
      paragraphs: [
        'Harper had once told Xeno the entire story behind why he was so sensitive about his past.',
        'And finally, Xeno understood.',
        'Inside the dark student council room, Harper looked at him quietly.',
        '“Are you going to avoid me too?”',
        'Xeno did not answer immediately. He was always careful with his words, especially when it came to Harper.',
        'The silence felt unbearably heavy.',
        'Harper spoke again.',
        '“Or are you going to spread my story to them too?”',
        'Three seconds.',
        'Five seconds.',
        'Finally, Xeno replied,',
        '“Never play an Ace until I have to.”',
        'Harper fell silent. He understood what Xeno meant, and a small smile slowly appeared on his face.',
        '“Thank you.”',
        'At school, the two of them became known as the Top Duo.',
        'Xeno protected Harper in the simplest way possible—by always staying beside him. No one dared to bring up Harper’s dark past anymore whenever Xeno was around.',
        'From then on, it was only Xeno and Harper against the whispers.',
        'Whenever Harper had to handle student council matters, Xeno would always accompany him. Slowly, the rumors and fearful whispers surrounding Harper began to disappear. Harper finally started interacting with other students again without overthinking every little thing.',
        'One afternoon, Xeno was alone on the school rooftop, enjoying the cool breeze and the beautiful sky while waiting for the sunset.',
        'Then he heard footsteps approaching.',
        'Of course, it was Harper.',
        'Harper sat beside him and stared at the same sky. Neither of them said anything, but moments like this made Harper realize just how lucky he was to have someone like Xeno in his life.',
        'And now, Harper silently promised himself that he would do the same for Xeno someday—to protect him from people who had no right to judge him.',
        '“If only you and I had more time,” Harper said softly, “I would always come back to you.”',
        'Xeno turned to look at him.',
        '“I’m transferring schools at the end of this semester.”',
      ],
    ),
    Chapter(
      label: 'Chapter 4',
      title: 'A Liar',
      paragraphs: [
        'Xeno stared at Harper for a long moment, trying to understand every word he had just said.',
        'Of course, he did not want to lose Harper. Harper was the very reason he had managed to stay at this school for so long.',
        'Xeno looked up at the sky before finally speaking.',
        '“I thought everything I did was enough to make you stay here.”',
        'Once again, silence surrounded them.',
        'Harper smiled softly and patted Xeno’s shoulder.',
        '“I have another goal now. That doesn’t mean I’ll stop contacting you, though. Trust me.”',
        'At first, Xeno believed him.',
        'But then one month passed.',
        'Then two.',
        'Maybe even almost three months without hearing properly from Harper.',
        'Xeno opened his phone and stared at their old conversations. Harper was busy with his new school now, and his messages had become painfully rare.',
        'Xeno stood on the rooftop again, staring at the night sky for a long time. Harper’s presence still lingered vividly in his mind.',
        'Slowly, Xeno closed his eyes, allowing himself to relive the memories they once shared in this school.',
        'The moment Harper made him laugh for the first time.',
        'The times Xeno encouraged Harper to keep interacting with the other students.',
        'The day Harper forced him to play games together, even though Harper himself was absolutely terrible at them.',
        'Every memory replayed clearly in his mind before Xeno finally opened his eyes again after hearing someone call his name.',
        'It was Artemis.',
        '“Miss him?”',
        'Xeno stayed silent.',
        'Artemis was the second person he had grown closest to in the student council, mainly because she was the council secretary and often spent time working alongside him.',
        'After a moment, Xeno finally answered,',
        '“No. I’m happy to see that he has something else keeping him busy now.”',
        'A lie.',
        'Xeno’s eyes could never lie, but Artemis only nodded gently.',
        '“Trust me. He’ll come back. There’s no way Harper could ever forget you, Xeno.”',
        'With those final words, Artemis eventually left him alone once again on the rooftop.',
        'The cold night wind brushed through Xeno’s black hair.',
        'This was exactly why Xeno never wanted to get too close to people in the first place.',
        'He was afraid of becoming comfortable.',
        'Afraid of depending too much on someone.',
        'Everything he did at school now—even student council activities—felt unbearably empty without Harper beside him.',
        'But deep down, Xeno also understood something else.',
        'He should not depend on Harper so much.',
        'Because Harper never depended on him either.',
      ],
    ),
    Chapter(
      label: 'Chapter 5',
      title: 'What I feared most had finally happened.',
      paragraphs: [
        'That night, a violent storm raged on. Harper came home late because he had been busy with student council duties at his new school.',
        'Through the heavy rain, he vaguely noticed the silhouette of a tall young man standing in the storm.',
        'The man seemed to be enjoying the rain, yet his body was covered in blood.',
        'At first, Harper was terrified, thinking the man might be a murderer. But as he looked more closely, he realized it was Xeno.',
        'His eyes widened. After almost six months since they had parted ways, he had finally seen Xeno again.',
        'Gathering his courage, Harper stepped onto the deserted road despite the pouring rain, carrying his umbrella. He held it over Xeno, shielding him from the storm.',
        'Slowly, Xeno turned his head.',
        'His cold blue eyes met Harper’s.',
        'For a moment, time seemed to stop. The freezing air suddenly felt warm.',
        '"What happened with you?!" Harper exclaimed in panic when he noticed that all of Xeno’s wounds were fresh and severe.',
        'Xeno showed no sign of happiness, but deep down, he was overjoyed to see that Harper was safe and doing well.',
        '"I got into a fight with students from another school."',
        'Harper froze in shock. Instantly forgetting about the umbrella, he grabbed Xeno by the shoulders and shook him roughly.',
        '"You\'re a student council, Xeno! Have you forgotten that?!" he shouted.',
        'Xeno looked at him calmly.',
        '"I\'m fine. You don\'t need to worry about me."',
        '"Don\'t need to worry? YOU\'RE HURT SO BAD, XENO FOSTER!"',
        '"Why do you suddenly care?"',
        'Harper fell silent.',
        'Xeno let out a quiet laugh. The pain in his heart was far deeper than all the knife wounds he had suffered that day.',
        '"Everything I was afraid of has come true. You\'re really doing just fine without me."',
        'Harper looked at him again.',
        '"Close friends doesn\'t meant to always talk all the time, Xeno."',
        '"But i do. I need it."',
        'At last, Xeno admitted it.',
        '"I\'m different from you, Harper. You seem perfectly happy at your new school, while I\'ve been thinking about you all this time. I\'ve wanted to talk to you more than anything."',
        'His voice grew hoarse.',
        '"You don\'t even read my messages anymore. You\'re always busy talking to other people. I saw you yesterday, from a distance."',
        'Harper froze.',
        'He had no idea that Xeno had been watching over him all this time.',
        'For a moment, the only sound between them was the rain.',
        'Finally, Harper lowered his head and spoke softly.',
        '"I\'m sorry."',
      ],
    ),
  ];

  int _selectedChapterIndex = 0;
  late final AnimationController _animationController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final ScrollController _scrollController;

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
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _selectChapter(int index) {
    setState(() {
      _selectedChapterIndex = index;
    });
    _animationController.forward(from: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOut,
      );
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
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    final maxContentWidth = 820.0; // keep content readable on large screens

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
                              onTap: () {
                                SystemSound.play(SystemSoundType.click);
                                _selectChapter(index);
                              },
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: isSelected ? 0.98 : 1.0, end: isSelected ? 1.02 : 1.0),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutBack,
                                builder: (context, scale, child) => Transform.scale(
                                  scale: scale,
                                  child: child,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF363D7A) : const Color(0xFF11131F),
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFF69E2FF) : Colors.white12,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF69E2FF).withAlpha(40),
                                              blurRadius: 18,
                                              offset: const Offset(0, 6),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      _chapters[index].label,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.white54,
                                        fontSize: 13,
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                      ),
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
                      duration: const Duration(milliseconds: 420),
                      transitionBuilder: (child, animation) {
                        final offset = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
                            .animate(animation);
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(position: offset, child: child),
                        );
                      },
                      child: SingleChildScrollView(
                        key: ValueKey(_selectedChapterIndex),
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxContentWidth),
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
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.width < 380 ? 20 : 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Text(
                                    storyText,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: MediaQuery.of(context).size.width < 360 ? 14 : 16,
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, 18 + bottomInset),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTapDown: (_) => SystemSound.play(SystemSoundType.click),
                          onTap: _selectedChapterIndex > 0 ? _showPreviousChapter : null,
                          child: AnimatedScale(
                            scale: _selectedChapterIndex > 0 ? 1.0 : 1.0,
                            duration: const Duration(milliseconds: 160),
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
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: GestureDetector(
                          onTapDown: (_) => SystemSound.play(SystemSoundType.click),
                          onTap: _selectedChapterIndex < _chapters.length - 1 ? _showNextChapter : null,
                          child: AnimatedScale(
                            scale: _selectedChapterIndex < _chapters.length - 1 ? 1.0 : 1.0,
                            duration: const Duration(milliseconds: 160),
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
