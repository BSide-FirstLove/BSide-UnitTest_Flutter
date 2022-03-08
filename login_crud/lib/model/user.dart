class User {
  final int id;
  final String nickname;
  final String image;

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nickname = map['nickname'],
        image = map['image'];

}
