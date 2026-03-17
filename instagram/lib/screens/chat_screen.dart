import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final messages = DummyData.chatMessages;
  int currentMessageIndex = 0;
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _showNextMessage() {
    if (currentMessageIndex < messages.length - 1) {
      setState(() {
        currentMessageIndex++;
        _animationController.reset();
        _animationController.forward();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('images/tele4.jpg'),
            ),
            SizedBox(width: 10),
            Row(
              children: [
                Text(
                  'xeno_foster',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.verified,
                  color: Colors.blue,
                  size: 12,
                ),
              ],
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: currentMessageIndex < messages.length - 1 ? _showNextMessage : null,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: currentMessageIndex + 1,
                itemBuilder: (context, index) {
                  final animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
                      .animate(_animationController);

                  return FadeTransition(
                    opacity: index == currentMessageIndex ? _fadeAnimation : const AlwaysStoppedAnimation(1.0),
                    child: SlideTransition(
                      position: index == currentMessageIndex ? animation : const AlwaysStoppedAnimation(Offset.zero),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF262626),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            messages[index],
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Text untuk next message
            if (currentMessageIndex < messages.length - 1)
              Padding(
                padding: const EdgeInsets.all(16),
                child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    '> tap to continue',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),

            // Input chat bawah
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.camera_alt_outlined),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF262626),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  const Icon(Icons.mic_none),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}