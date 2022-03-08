import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_crud/model/state.dart';
import 'package:provider/provider.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference posts = FirebaseFirestore.instance.collection('post');
    Future<void> addUser() {
      return posts
          .add({
            'user': context.read<UserState>().user.single.toMap(),
            'title': "글쓰기테스트 제목11",
            'content': "글쓰기테스트 내용11",
            'dateCreated': DateTime.now()
          })
          .then((value) => print("Post Added"))
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
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: '여기에 입력하셈'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white30),
              onPressed: addUser,
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
