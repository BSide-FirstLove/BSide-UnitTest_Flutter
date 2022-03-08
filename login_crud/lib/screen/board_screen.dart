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
  List<Post> posts = [
    Post.fromMap({
      'user': User.fromMap({
        'id': 2150582550,
        "nickname": '메돌이1',
        'image': 'https://post-phinf.pstatic.net/MjAyMDA2MDRfMjcz/MDAxNTkxMjMyNDIwODAy.Zb1gf9wnPBXyh2iwqt6WbG9NVlwKAbA0aZb3VCtLS28g.PZ22F-FY0uq_7snQ3i_VNcmBLDWkZA4Vv1wE_MsxBBcg.JPEG/fsdfsdf.JPG.jpg?type=w1200'
      }),
      'title': "테스트 제목1",
      'content': "테스트 내용1",
      'dateCreated': DateTime.now()
    }),
    Post.fromMap({
      'user': User.fromMap({
        'id': 2,
        "nickname": '메돌이2',
        'image': 'https://post-phinf.pstatic.net/MjAyMDA2MDRfMjcz/MDAxNTkxMjMyNDIwODAy.Zb1gf9wnPBXyh2iwqt6WbG9NVlwKAbA0aZb3VCtLS28g.PZ22F-FY0uq_7snQ3i_VNcmBLDWkZA4Vv1wE_MsxBBcg.JPEG/fsdfsdf.JPG.jpg?type=w1200'
      }),
      'title': "테스트 제목2",
      'content': "테스트 내용2",
      'dateCreated': DateTime.now()
    }),
    Post.fromMap({
      'user': User.fromMap({
        'id': 3,
        "nickname": '메돌이3',
        'image': 'https://post-phinf.pstatic.net/MjAyMDA2MDRfMjcz/MDAxNTkxMjMyNDIwODAy.Zb1gf9wnPBXyh2iwqt6WbG9NVlwKAbA0aZb3VCtLS28g.PZ22F-FY0uq_7snQ3i_VNcmBLDWkZA4Vv1wE_MsxBBcg.JPEG/fsdfsdf.JPG.jpg?type=w1200'
      }),
      'title': "테스트 제목3",
      'content': "테스트 내용3",
      'dateCreated': DateTime.now()
    }),
    Post.fromMap({
      'user': User.fromMap({
        'id': 4,
        "nickname": '메돌이4',
        'image': 'https://post-phinf.pstatic.net/MjAyMDA2MDRfMjcz/MDAxNTkxMjMyNDIwODAy.Zb1gf9wnPBXyh2iwqt6WbG9NVlwKAbA0aZb3VCtLS28g.PZ22F-FY0uq_7snQ3i_VNcmBLDWkZA4Vv1wE_MsxBBcg.JPEG/fsdfsdf.JPG.jpg?type=w1200'
      }),
      'title': "테스트 제목4",
      'content': "테스트 내용4",
      'dateCreated': DateTime.now()
    })
  ];

  @override
  Widget build(BuildContext context) {
    // User user1 = context.read<UserState>().user;
    // User user2 = Provider.of<UserState>(context).user;
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
              child: Icon(Icons.add_box, color: Colors.white),
              backgroundColor: Colors.redAccent,
            ),
          ),
        ),
      ],
    ));
  }
}
