import '../models/post_item.dart';

class DummyData {
  static const String profileImage = 'images/tele4.jpg';

  static const String username = 'xeno_foster';
  static const String profileName = 'xeno foster';

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