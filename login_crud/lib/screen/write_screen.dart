import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_crud/model/state.dart';
import 'package:provider/provider.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleInputController = TextEditingController();
    final contentInputController = TextEditingController();
    final CollectionReference posts = FirebaseFirestore.instance.collection('post');
    Future<void> addPost() {
      return posts
          .add({
            'user': context.read<UserState>().user.single.toMap(),
            'title': titleInputController.text,
            'content': contentInputController.text,
            'dateCreated': DateTime.now()
          })
          .then((value) => Navigator.pop(context, true))
          .catchError((error) => print("Failed to add post: $error"));
    }

    return Scaffold(
      appBar: AppBar(title: Text("글쓰기")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: titleInputController,
              maxLines: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: '제목'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: contentInputController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: '내용'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white30),
              onPressed: addPost,
              child: Text(
                "작성 완료",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
