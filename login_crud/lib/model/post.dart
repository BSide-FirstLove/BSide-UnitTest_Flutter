
import 'package:login_crud/model/user.dart';

class Post {
  final String userID;
  final String title;
  final String content;
  final DateTime dateCreated;

  Post.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        title = map['title'],
        content = map['content'],
        dateCreated = map['dateCreated'];
  String getDateCreated() {
    return "${dateCreated.month} 월 ${dateCreated.day} 일";
  }
}
