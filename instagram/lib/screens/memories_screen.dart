import 'package:flutter/material.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({super.key});

  @override
  State<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _introController;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 540),
    );

    _fadeIn = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOut,
    );

    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _introController.forward();
      }
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }

  Widget _buildImageCard(String asset, String label) {
    return ScaleTransition(
      scale: _fadeIn,
      child: SizedBox(
        height: 220,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2A0D3C),
                Color(0xFF0C0713),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(89),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
            border: Border.all(color: Colors.white12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    asset,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withAlpha(115),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(115),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF9B82FF),
        fontSize: 14,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDescription(String text, bool isNarrow) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withAlpha(224),
        fontSize: isNarrow ? 13 : 15,
        height: 1.7,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 360;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF05030A),
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0A0421),
                    Color(0xFF09070E),
                    Color(0xFF11081F),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF8C3BFF).withAlpha(45),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 120,
            right: -80,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00D4FF).withAlpha(30),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  SlideTransition(
                    position: _slideIn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white24),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),

                        Column(
                          children: const [
                            Text(
                              'Memories',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Game nights and close moments',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 40),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeTransition(
                                  opacity: _fadeIn,
                                  child: const Text(
                                    'Xeno and Harper always spend time together playing games.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      height: 1.4,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // ROBLOX SECTION
                                SlideTransition(
                                  position: _slideIn,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF130E1F)
                                          .withAlpha(242),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.white10,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildSectionTitle('ROBLOX:'),

                                        const SizedBox(height: 12),

                                        _buildDescription(
                                          'It has become their favorite thing to always try to finish every game they play. Some of the games they have completed include Peta Peta Season One, SpongeBob, and many other horror games that they never had the chance to screenshot.',
                                          isNarrow,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildImageCard(
                                        'images/tele25.jpg',
                                        'Save all Spongebob Characters',
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    Expanded(
                                      child: _buildImageCard(
                                        'images/tele26.jpg',
                                        'Xeno w Harper 99 nightmares',
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 26),

                                FadeTransition(
                                  opacity: _fadeIn,
                                  child: Text(
                                    'Whenever they truly have free time, they always choose to spend it together. They usually play games while staying connected on Discord so they can communicate properly and guide each other during the game.',
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(214),
                                      fontSize:
                                          isNarrow ? 13 : 15,
                                      height: 1.7,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // MOBILE LEGENDS SECTION
                                SlideTransition(
                                  position: _slideIn,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF130E1F)
                                          .withAlpha(242),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.white10,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildSectionTitle(
                                          'MOBILE LEGENDS:',
                                        ),

                                        const SizedBox(height: 12),

                                        _buildDescription(
                                          'Xeno and Harper also used to play Mobile Legends very often. Interestingly, Xeno frequently changed accounts because he would easily get bored, which is why their affinity level always remained low.',
                                          isNarrow,
                                        ),

                                        const SizedBox(height: 18),

                                        _buildDescription(
                                          'Instead of being afraid of getting taunted by enemies, they actually enjoyed provoking them by becoming lovers in the game. Being lovers made them feel challenged because most Mobile Legends players tend to feel intimidated whenever they see a couple playing together.',
                                          isNarrow,
                                        ),

                                        const SizedBox(height: 18),

                                        _buildDescription(
                                          'Did the insults hurt them? Of course not. It only made them even more excited and motivated. The more people underestimated them, the stronger the duo became.',
                                          isNarrow,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildImageCard(
                                        'images/tele27.jpg',
                                        'That Angela Lancelot Combo',
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    Expanded(
                                      child: _buildImageCard(
                                        'images/tele28.jpg',
                                        'Lovers to mocking enemy',
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 28),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A122B),
                                    borderRadius:
                                        BorderRadius.circular(24),
                                    border: Border.all(
                                      color: const Color(0xFF7C5FFF)
                                          .withAlpha(64),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Special moments',
                                        style: TextStyle(
                                          color: Color(0xFF7C5FFF),
                                          fontSize: 14,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      SizedBox(height: 10),

                                      Text(
                                        'Moments like these are very special and enjoyable for Xeno. Hearing Harper’s voice — or even his screams and curses while playing games — is one of Xeno’s favorite things.',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                          height: 1.75,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}