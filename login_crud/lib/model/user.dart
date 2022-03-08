import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao_user;

class User {
  final int id;
  final String nickname;
  final String image;

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nickname = map['nickname'],
        image = map['image'];

  User.fromKakao(kakao_user.User user)
      : id = user.id,
        nickname = user.kakaoAccount!.profile!.nickname!,
        image = user.kakaoAccount!.profile!.thumbnailImageUrl!;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'image': image
    };
  }
}
