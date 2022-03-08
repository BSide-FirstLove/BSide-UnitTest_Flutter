class User {
  final int id;
  final String name;
  final String image;

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        image = map['image'];
}
