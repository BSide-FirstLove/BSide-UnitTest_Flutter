import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_crud/model/post.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
    bool isRight = false;
    List<Widget> _actionsItem() {
      List<Widget> results = [];
      if(isRight){
        results.add(IconButton(onPressed: () {}, icon: Icon(Icons.edit)));
        results.add(IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever_rounded)));
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
      body: SingleChildScrollView(  //  키보드 표시될시 경고 처리위해 사용
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text("제목 : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text("글쓴이 : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text("작성일 : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    maxLines: 5,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )
              ),
              isRight? Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white30),
                  onPressed: () {},
                  child: Text(
                    "작성 완료",
                    style: TextStyle(
                        color: Colors.white),),),
              )
                  : Container()
            ],
          ),
        ),
      )
    );
  }
}
