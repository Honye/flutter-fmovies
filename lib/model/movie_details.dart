
class MovieDetails {
  final Map rating;  // 评分
  final int wishCount;  // 想看人数
  final Map images;
  final String year;
  final String alt;
  final String id;
  final String title;
  final List language;
  final List<String> tags;
  final List<String> genres;
  final List<String> countries;
  final String mainlandPubdate;
  final String summary;
  final String subtype;
  final List<String> durations;
  final List<String> pubdates;

  factory MovieDetails(Map jsonMap) =>
    MovieDetails._fromJson(jsonMap);

  MovieDetails._fromJson(Map jsonMap)
    : rating = jsonMap['rating'],
      wishCount = jsonMap['wish_count'],
      images = jsonMap['images'],
      year = jsonMap['year'],
      alt = jsonMap['alt'],
      id = jsonMap['id'],
      title = jsonMap['title'],
      language = jsonMap['language'],
      tags = jsonMap['tags'].map<String>((item) => item.toString()).toList(),
      genres = jsonMap['genres'].map<String>((item) => item.toString()).toList(),
      countries = jsonMap['countries'].map<String>((item) => item.toString()).toList(),
      mainlandPubdate = jsonMap['mainland_pubdate'],
      summary = jsonMap['summary'],
      subtype = jsonMap['subtype'],
      durations = jsonMap['durations'].map<String>((item) => item.toString()).toList(),
      pubdates = jsonMap['pubdates'].map<String>((item) => item.toString()).toList();
}