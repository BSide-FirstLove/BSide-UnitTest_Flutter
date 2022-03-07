import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login_crud/screen/login_screen.dart';
import 'package:login_crud/widget/bottom_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  final bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JH',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      home: const LoginScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          // physics: NeverScrollableScrollPhysics(), //  페이지 스크롤 여부
          children: <Widget>[
            Container(
              child: Center(child: Text("1"),),
            ),
            Container(
              child: Center(child: Text("2"),),
            ),
          ],
        ),
        bottomNavigationBar: const Bottom(),
      ),
    );
  }
}