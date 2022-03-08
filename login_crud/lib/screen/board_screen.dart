import 'package:flutter/material.dart';
import 'package:login_crud/model/post.dart';
import 'package:login_crud/model/user.dart';
import 'package:login_crud/screen/write_screen.dart';
import 'package:login_crud/widget/box_post.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  User user = User.fromMap({'id': 123124, 'name': '한재현', 'image': 'imageurl'});
  List<Post> posts = [
    Post.fromMap({
      'userID': "141414",
      'title': "테스트 제목1",
      'content': "테스트 내용1",
      'dateCreated': DateTime.now()
    }),
    Post.fromMap({
      'userID': "141414",
      'title': "테스트 제목2",
      'content': "테스트 내용2",
      'dateCreated': DateTime.now()
    }),
    Post.fromMap({
      'userID': "141414",
      'title': "테스트 제목3",
      'content': "테스트 내용3",
      'dateCreated': DateTime.now()
    }),
    Post.fromMap({
      'userID': "141414",
      'title': "테스트 제목4",
      'content': "테스트 내용",
      'dateCreated': DateTime.now()
    })
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        BoxPost(posts: posts),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 30),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                //  Navigator = 스택을 이용해 페이지 관리
                //  MaterialPageRoute = 머티리얼 스타일로 페이지 이동
                Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) {
                      return WriteScreen();
                    }));
              },
              child: Icon(Icons.add_comment),
              backgroundColor: Colors.redAccent,
            ),
          ),
        ),
      ],
    ));
  }
}
