import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_crud/model/post.dart';
import 'package:login_crud/screen/write_screen.dart';
import 'package:login_crud/widget/box_post.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  final Stream<QuerySnapshot> _postStream = FirebaseFirestore.instance.collection('post').snapshots();
  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _postStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(); //로딩 화면
        }
        return _buildBody(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Post> posts = snapshot.map((d) => Post.fromSnapshot(d)).toList();
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
                      builder: (context) => WriteScreen()));
                },
                child: Icon(Icons.add_box, color: Colors.white),
                backgroundColor: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // User user1 = context.read<UserState>().user;
    // User user2 = Provider.of<UserState>(context).user;
    return _fetchData(context);
  }
}
