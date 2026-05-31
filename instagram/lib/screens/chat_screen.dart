import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController =
    TextEditingController();

bool _secretUnlocked = false;

int hiddenMessageIndex = 0;

final List<Map<String, dynamic>> messages = [];

int currentMessageIndex = 0;

late ScrollController _scrollController;
late AnimationController _animationController;
late Animation<double> _fadeAnimation;
  
@override
void initState() {
  super.initState();

  _scrollController = ScrollController();

  for (final msg in DummyData.chatMessages) {
    messages.add({
      "text": msg,
      "isUser": false,
    });
  }

  _messageController.addListener(() {
    setState(() {});
  });

  _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  _fadeAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ),
  );

  _animationController.forward();
}

void _scrollToBottom() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOut,
    );
  });
}

void _showSecretNotification() {
  final overlay = Overlay.of(context);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => Positioned(
      top: 90,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0,
            end: 1,
          ),
          duration: const Duration(
            milliseconds: 300,
          ),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(
                0,
                -20 * (1 - value),
              ),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: const Color(
                0xFF1F1F1F,
              ),
              borderRadius:
                  BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white12,
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.lock_open,
                  color: Colors.green,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Hidden conversation unlocked",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);

  Future.delayed(
    const Duration(seconds: 2),
    () {
      entry.remove();
    },
  );
}

@override
void dispose() {
  _scrollController.dispose();
  _animationController.dispose();
  _messageController.dispose();
  super.dispose();
}

void _showNextMessage() {
  if (currentMessageIndex <
      messages.length - 1) {
    setState(() {
      currentMessageIndex++;
    });

    _animationController.reset();
    _animationController.forward();

    _scrollToBottom();
    return;
  }

  if (_secretUnlocked &&
      hiddenMessageIndex <
          DummyData.hiddenMessages.length) {
    setState(() {
      messages.add({
        "text":
            DummyData.hiddenMessages[
                hiddenMessageIndex],
        "isUser": false,
      });

      hiddenMessageIndex++;
      currentMessageIndex++;
    });

    _animationController.reset();
    _animationController.forward();

    _scrollToBottom();
  }
}
    
void _sendMessage() {
  final text =
      _messageController.text.trim();

  if (text.isEmpty) return;

  setState(() {
    messages.add({
      "text": text,
      "isUser": true,
    });

    currentMessageIndex =
        messages.length - 1;
  });

  _scrollToBottom();

  if (text.toLowerCase() ==
          DummyData.secretKeyword
              .toLowerCase() &&
      !_secretUnlocked) {
    setState(() {
      _secretUnlocked = true;

      messages.add({
        "text":
            DummyData.hiddenMessages[0],
        "isUser": false,
      });

      currentMessageIndex =
          messages.length - 1;

      hiddenMessageIndex = 1;
    });

    _scrollToBottom();

    _showSecretNotification();
  }

  _messageController.clear();
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
        onTap: () {
  if (currentMessageIndex <
          messages.length - 1 ||
      (_secretUnlocked &&
          hiddenMessageIndex <
              DummyData
                  .hiddenMessages
                  .length)) {
    _showNextMessage();
  }
},
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: currentMessageIndex + 1,
                itemBuilder: (context, index) {
  final msg = messages[index];

  final isUser =
      msg["isUser"] as bool;

  final animation =
      Tween<Offset>(
    begin: const Offset(0, 0.2),
    end: Offset.zero,
  ).animate(_animationController);

  return FadeTransition(
    opacity: index ==
            currentMessageIndex
        ? _fadeAnimation
        : const AlwaysStoppedAnimation(
            1,
          ),
    child: SlideTransition(
      position:
          index ==
                  currentMessageIndex
              ? animation
              : const AlwaysStoppedAnimation(
                  Offset.zero,
                ),
      child: Align(
        alignment: isUser
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
  maxWidth: MediaQuery.of(context).size.width * .70,
),
          margin: EdgeInsets.only(
  bottom: 12,
  left: isUser ? 80 : 0,
  right: isUser ? 0 : 80,
),
          padding:
              const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          
          decoration: BoxDecoration(
            color: isUser
    ? const Color(0xFF2D88FF)
    : const Color(0xFF262626),
            borderRadius: BorderRadius.only(
  topLeft: const Radius.circular(20),
  topRight: const Radius.circular(20),
  bottomLeft: Radius.circular(
      isUser ? 20 : 4),
  bottomRight: Radius.circular(
      isUser ? 4 : 20),
            ),
          ),
          child: Text(
            msg["text"],
            style:
                const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    ),
  );
},
              ),
            ),
            // Text untuk next message
            
            if (
  currentMessageIndex <
      messages.length - 1 ||
  (_secretUnlocked &&
   hiddenMessageIndex <
       DummyData
           .hiddenMessages
           .length)
)
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
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  ),
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
          child: TextField(
            controller: _messageController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: "Message...",
              border: InputBorder.none,
            ),
          ),
        ),
      ),

      const SizedBox(width: 10),

      IconButton(
        onPressed: _messageController.text.trim().isEmpty
            ? null
            : _sendMessage,
        icon: Icon(
          _messageController.text.trim().isEmpty
              ? Icons.mic_none
              : Icons.send,
          color: Colors.white,
        ),
      ),
    ],
  ),
)
              
        
          ],
        ),
      ),
    );
  }
}