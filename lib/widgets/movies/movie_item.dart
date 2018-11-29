import 'package:flutter/material.dart';
import '../../model/movie_item.dart' as ModelMovie;
import './movie_details.dart';

class MovieItem extends StatelessWidget {
  MovieItem(this.movie);

  final ModelMovie.MovieItem movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(movie.id),
      leading: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/placeholder.jpg',
          image: movie.images['medium'],
          width: 55.0,
          height: 55.0,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(
          '豆瓣评分：${movie.rating['average'] != 0 ? movie.rating['average'] : "暂无评分"}'),
      trailing: IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: null,
      ),
      onTap: () => _pushDetails(context),
    );
  }

  _pushDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MovieDetails(movie.id, movie.title),
      )
    );
  }
}
