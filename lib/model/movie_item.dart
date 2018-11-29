class MovieItem {
    final Map rating;
    final List<String> genres;
    final String title;
    final Map images;
    final String id;

    factory MovieItem(Map jsonMap) =>
        MovieItem._fromJson(jsonMap);

    MovieItem._fromJson(Map jsonMap)
        : rating = jsonMap['rating'],
          genres = jsonMap['genres'].map<String>((item) => item.toString()).toList(),
          title = jsonMap['title'],
          images = jsonMap['images'],
          id = jsonMap['id'];

    Map toJson() => {
        'rating': rating,
        'genres': genres,
        'title': title,
        'images': images,
        'id': id,
    };
}
