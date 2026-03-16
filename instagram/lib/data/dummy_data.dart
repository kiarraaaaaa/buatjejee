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
        imageUrl: 'images/tele18.jpg',
        caption: 'late night ride with the crew.',
        likes: 222410,
        comments: [
          'this goes insanely hard',
          'mono tone looks perfect',
          'rider era fr',
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
          'love the street mood',
          'this is fire',
        ],
      ),
      PostItem(
        id: '4',
        username: 'xeno_foster',
        userFullName: 'xeno foster',
        userAvatar: profileImage,
        imageUrl: 'images/tele3.jpg',
        caption: 'duo, no noise, just motion.',
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
          'hot as fuck'
        ],
      ),
    ];
  }

  static const List<String> chatMessages = [
    'hello, je',
    'how? you like it?',
    'its our secret talk',
    'i just want to say that i love you',
    'even though we cant, i cant lie to my feelings',
    'but thats okay, i love us in this way',
    'you can text here but you cant send it. just replied on my telegram, kay?'
  ];
}