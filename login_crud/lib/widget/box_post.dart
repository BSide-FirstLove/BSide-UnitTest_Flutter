import 'package:flutter/material.dart';
import 'package:login_crud/model/post.dart';
import 'package:login_crud/screen/detail_screen.dart';

class BoxPost extends StatelessWidget {
  const BoxPost({Key? key, required this.posts}) : super(key: key);
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: EdgeInsets.all(15),
          child: Row(
            // children 정렬 설정
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/baby2.jpg'),
              ),
              Container(
                width: 265,
                padding: EdgeInsets.only(left: 15),
                child: Text(posts[i].title)
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Text(posts[i].getDateCreated()),
                    Text(posts[i].user.nickname)
                  ],
                ),
              ),
            ],
        ),
      ),
    ));
  }
  return results;
}
