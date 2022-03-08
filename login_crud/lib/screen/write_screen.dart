import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  @override
  Widget build(BuildContext context) {
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
                  border: OutlineInputBorder(),
                  labelText: '여기에 입력하셈'
              ),
            ),),
          Container(
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
        ],
      ),
    );
  }
}