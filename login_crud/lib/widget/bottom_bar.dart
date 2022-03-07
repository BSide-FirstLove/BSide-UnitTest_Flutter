import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        height: 50,
        child: const TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.departure_board,
                size: 20,
              ),
              child: Text(
                '게시판',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.map,
                size: 20,
              ),
              child: Text(
                '지도',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
