import 'package:flutter/material.dart';

void main() {
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
      home: isLogin ? const HomeScreen() : const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  //세로 가운데 정렬
          children: [
            Container(
              child: const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('images/kakao_logo.png'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: const Text(
                'login_crud',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: 130,
              height: 5,
              color: Colors.red,
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {},
                child: Image.asset('images/kakao_login_medium_narrow.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('로그인됨-홈화면'),
    );
  }
}
