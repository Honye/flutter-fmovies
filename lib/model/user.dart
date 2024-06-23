class User {
  final int id;
  final String avatar;
  final String name;

  factory User(Map jsonMap) => User._fromJson(jsonMap);

  User._fromJson(Map jsonMap)
    : id = jsonMap['id'].toInt(),
      avatar = jsonMap['avatar_url'],
      name = jsonMap['login'];
}
