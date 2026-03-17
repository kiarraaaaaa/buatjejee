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
    'hello, partner.',
    'how? you like it?',
    'i just want to say, thank you for everything.',
    'and im so sorry bout all my mistakes ive ever did',
    'tbh, i love us in this way',
    'lu adalah satu satunya yang gua punya, di telegram ini.',
    'thank you udah bertahan sama sikap gua yang kadang menyebalkan',
    'makasi tetap bertahan walau kita pernah beda pendapat',
    'dan makasi juga udah selalu ada disaat gua butuh',
    'and you must know that, i love to heard your voice so much.',
    'so, keep talkin much when only two of us in this world',
    'keep yapping pas kita lagi dc bareng',
    'tetep ceritain segala hal yang perlu gua tau',
    'because i love heard a lot bout you.',
    'you can text here but you cant send it. just replied on my telegram, kay?',
    'last, hope we keep goin like this.',
    'not in a romantic way but care each other.'
  ];
}