import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login_crud/model/state.dart';
import 'package:login_crud/screen/board_screen.dart';
import 'package:login_crud/screen/login_screen.dart';
import 'package:login_crud/screen/map_screen.dart';
import 'package:login_crud/widget/bottom_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'));
  //  Firebase init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  Google Map
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(
      ChangeNotifierProvider(
        create: (context) => UserState(),
        child: const MyApp(),
      )
  );
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
    List<String> titleAppbar = ['게시판','지도'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('login_crud')),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(), //  페이지 스크롤 여부
          children: <Widget>[
            BoardScreen(),
            MapScreen(),
          ],
        ),
        bottomNavigationBar: Bottom(),
      ),
    );
  }
}
