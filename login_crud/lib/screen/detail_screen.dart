import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_crud/model/post.dart';
import 'package:login_crud/model/state.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isRight = false;
  bool isEdit = false;
  final titleInputController = TextEditingController();
  final contentInputController = TextEditingController();
  final CollectionReference posts =
  FirebaseFirestore.instance.collection('post');

  @override
  initState() {
    super.initState();
    isRight = context.read<UserState>().user.single.id == widget.post.user.id;
    titleInputController.text = widget.post.title;
    contentInputController.text = widget.post.content;
  }

  Future<void> updatePost() {
    return posts
        .doc(widget.post.reference.id)
        .update({
      'title': titleInputController.text,
      'content': contentInputController.text,
    })
        .then((value) => _successUpdate())
        .catchError((error) => print("Failed to update post: $error"));
  }

  Future<void> deleteUser() {
    return posts
        .doc(widget.post.reference.id)
        .delete()
        .then((value) => Navigator.pop(context, true))
        .catchError((error) => print("Failed to delete post: $error"));
  }

  _successUpdate() {
    widget.post.title = titleInputController.text;
    widget.post.content = contentInputController.text;
    setState(() {
      isEdit = false;
    });
  }

  List<Widget> _actionsItem() {
    List<Widget> results = [];
    if (isRight) {
      results.add(IconButton(
          onPressed: () {
            setState(() {
              isEdit = true;
            });
          },
          icon: Icon(Icons.edit)));
      results.add(IconButton(
          onPressed: deleteUser, icon: Icon(Icons.delete_forever_rounded)));
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('상세보기'),
          actions: _actionsItem(),
        ),
        body: SingleChildScrollView(
          //  키보드 표시될시 경고 처리위해 사용
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "글쓴이 : " + widget.post.user.nickname,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "작성일 : " + widget.post.getDateCreated(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: titleInputController,
                      maxLines: 1,
                      enabled: isEdit,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: '제목'),
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: contentInputController,
                      maxLines: 5,
                      enabled: isEdit,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: '내용'),
                    )),
                isEdit
                    ? Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white30),
                              onPressed: () {
                                setState(() {
                                  isEdit = false;
                                });
                              },
                              child: Text(
                                "수정 취소",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 20)),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white30),
                              onPressed: updatePost,
                              child: Text(
                                "수정 완료",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ))
                    : Container()
              ],
            ),
          ),
        ));
  }
}
