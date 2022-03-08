import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_crud/model/user.dart';

class Post {
  final User user;
  final String title;
  final String content;
  final Timestamp dateCreated;
  final DocumentReference reference;

  Post.fromMap(Map<String, dynamic> map, {required this.reference})
      : user = User.fromMap(map['user']),
        title = map['title'],
        content = map['content'],
        dateCreated = map['dateCreated'];

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  String getDateCreated() {
    return "${dateCreated.toDate().month} 월 ${dateCreated.toDate().day} 일";
  }
}
