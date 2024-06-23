import 'package:FMovies/model/user.dart';

class Repo {
  final int id;
  final String name;
  final User owner;

  factory Repo(Map<String, dynamic> jsonMap) => Repo._fromJson(jsonMap);

  Repo._fromJson(Map<String, dynamic> jsonMap)
    : id = jsonMap['id'].toInt(),
      name = jsonMap['name'],
      owner = User(jsonMap['owner']);
}
