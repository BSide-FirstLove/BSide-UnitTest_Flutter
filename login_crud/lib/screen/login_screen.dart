import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login_crud/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = false;

  _checkToken() async {
    try{
      await UserApi.instance.accessTokenInfo();
      setState(() {
        isLogin = true;
      });
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        print('토큰 만료 $error');
      } else {
        print('토큰 정보 조회 실패 $error');
      }
    }
  }

  _kakaoLogin() async {
    // 카카오톡 설치 여부 확인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공11');
        print(token);
        _loginSuccess();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {}
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공22');
          print(token);
          _loginSuccess();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공33');
        print(token);
        _loginSuccess();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  _loginSuccess() async {
    await _getUser();
    setState(() {
      isLogin = true;
    });
  }

  _loginFailed() {

  }

  _getUser() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLogin? const HomeScreen() :
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                onPressed: () {_kakaoLogin();},
                child: Image.asset('images/kakao_login_medium_narrow.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}