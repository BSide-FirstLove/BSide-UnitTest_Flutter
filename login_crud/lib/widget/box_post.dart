import 'package:flutter/material.dart';
import 'package:login_crud/model/post.dart';
import 'package:login_crud/screen/detail_screen.dart';

class BoxPost extends StatelessWidget {
  const BoxPost({Key? key, required this.posts}) : super(key: key);
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: ListView(
          children: _makeBoardItem(context, posts),
        ));
  }
}

List<Widget> _makeBoardItem(BuildContext context, List<Post> posts) {
  List<Widget> results = [];
  for (var i = 0; i < posts.length; i++) {
    results.add(InkWell(
      // 제스쳐 추가 위젯
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(post: posts[i]);
            }));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // children 정렬 설정
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/baby2.jpg'),
            ),
            Text(posts[i].title),
            Column(
              children: [
                Text(posts[i].dateCreated.toString()),
                Text(posts[i].userID)
              ],
            )
          ],
        )),
      ),
    ));
  }
  return results;
}
