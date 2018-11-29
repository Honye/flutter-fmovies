class Movie {
  final int id;
  final double voteAverage;
  final String title;
  final String releaseDate;
  final String backdropPath;

  Movie({this.id, this.voteAverage, this.title, this.releaseDate, this.backdropPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toInt(),
      voteAverage: json['vote_average'].toDouble(),
      title: json['title'],
      releaseDate: json['release_date'],
      backdropPath: json['backdrop_path'],
    );
  }
}