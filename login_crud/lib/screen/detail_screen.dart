import 'package:flutter/material.dart';
import 'package:login_crud/model/post.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('상세보기'),);
  }

}