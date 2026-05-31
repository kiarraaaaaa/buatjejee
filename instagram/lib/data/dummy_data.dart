import '../models/post_item.dart';

class DummyData {
  static const String profileImage = 'images/tele4.jpg';

  static const String username = 'xeno_foster';
  static const String profileName = 'xeno foster';
  static const String secretKeyword = 'harper';

  static const String secretTitle =
      'Congrats! You found the hidden conversation!';

  static const List<String> hiddenMessages = [
    'Is that you, right?',
    'You know Harper, i can\'t lie to my self.',
    'I used to have feelings for you because I felt that comfortable with you. That\'s why I always wanted to keep communicating with you.',
    'Even the smallest things we\'ve done together keep replaying in my mind. It\'s because there was a time when I genuinely liked you.',
    'I know I was wrong to confess this, and I only want you to know how I feel, Je.',
    'I\'m also comfortable with the relationship we have now, even though sometimes I wish it could be more romantic.',
    'I know you\'ve been trying to keep some distance so that I wouldn\'t get too deeper feelings for you',
    'I\'m sorry if my feelings have made things difficult for you, or made our relationship less comfortable than it used to be.',
    'But believe me, I\'m okay',
    'Even if one day you become close to someone else, I\'ll be ready for that.',
    'So please, keep telling me about whatever is going on in your life, okay?',
    'Thank you for being my platonic partner.',
    'I\'m really happy that we\'ve become this close.',
    'From your partner, Xeno Foster.',
  ];

  static List<PostItem> posts() {
    return [
      PostItem(
        id: '1',
        username: 'xeno_foster',
        userFullName: 'xeno foster',
        userAvatar: profileImage,
        imageUrl: 'images/tele16.jpg',
        caption: 'hello guys! just wanna let you know that he is my partner.',
        likes: 184182,
        comments: [
          'bro this shot is cold',
          'harper? you guys suits sm!',
          'duo hottie!!!',
        ],
      ),
      PostItem(
        id: '2',
        username: 'xeno_foster',
        userFullName: 'xeno foster',
        userAvatar: profileImage,
        imageUrl: 'images/tele19.jpg',
        caption: 'late night with him.',
        likes: 222410,
        comments: [
          'this goes insanely hard',
          'JEXE looks perfect!',
          'duo puncak fr',
        ],
      ),
      PostItem(
        id: '3',
        username: 'xeno_foster',
        userFullName: 'xeno foster',
        userAvatar: profileImage,
        imageUrl: 'images/tele2.jpg',
        caption: 'fast lane, calm mind.',
        likes: 167194,
        comments: [
          'super cool frame',
          'XJ vibes badazzzz af',
          'this is fireee',
        ],
      ),
      PostItem(
        id: '4',
        username: 'xeno_foster',
        userFullName: 'xeno foster',
        userAvatar: profileImage,
        imageUrl: 'images/tele3.jpg',
        caption: 'with harper, everything feels perfect.',
        likes: 102461,
        comments: [
          'crazy clean post',
          'album cover material',
          'black fits this perfectly',
        ],
      ),
      PostItem(
        id: '5',
        username: 'xeno_foster',
        userFullName: 'xeno foster',
        userAvatar: profileImage,
        imageUrl: 'images/tele5.jpg',
        caption: 'our sidejob except ride.',
        likes: 259320,
        comments: [
          'the composition is crazy good',
          'need more posts like this',
          'xeno and harper are hot as fuck'
        ],
      ),
    ];
  }

  static const List<String> chatMessages = [
    'If people were to ask me, “Why Harper?”',
    'Then my answer would simply be this:',
    'Because he is the very definition of Jihoon himself.',
    'Perfect in perfection.',
    'And why do I care about him so much?',
    'Honestly, I do not know either.',
    'I just want to stay by his side, spend more time with him, and create countless memories together.',
    'Of course, we have fought before. We argued, disagreed, and hurt each other at times.',
    'But none of it ever became something serious.',
    'Because we never tried to destroy each other behind our backs.',
    'That is exactly why I love being friends with Harper.',
    'Because he is loyalty itself.',
  ];
}

