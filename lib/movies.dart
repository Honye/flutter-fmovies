import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './model/movie.dart';
import './model/movie_item.dart';
import './model/media_list.dart';
import './widgets/movies/movie_item.dart' as MovieWidget;
import './util/utils.dart';

class MovieList extends StatefulWidget {
    @override
    MovieListState createState() => new MovieListState();
}

class MovieListState extends State<MovieList> /*with AutomaticKeepAliveClientMixin*/ {
  List<Movie> _movies = <Movie>[];
  MediaList _mediaList = MediaList();
  int _pageNumber = 1;
  LoadingState _loadingState = LoadingState.LOADING;
  bool _isLoading = false;
  String errMsg = 'Sorry, there was an error loading the data!';

  void _loadMovies() async {
    _isLoading = true;
    final uri = Uri.https('api.themoviedb.org', '3/movie/popular', {
      'api_key': '1258165a9621d481b6fce5f5e191ff32',
      'page': _pageNumber.toString(),
    });
    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        var results = json.decode(response.body)['results'];
        var mJson = results.map((item) => {
          'rating': { 'average': item['vote_average'] },
          'genres': item['genre_ids'],
          'title': item['title'],
          'images': { 'medium': 'https://image.tmdb.org/t/p/w300${item["poster_path"]}' },
          'id': item['id'].toString(),
        });
          var data = mJson.map<MovieItem>((item) => MovieItem(item)).toList();
        var movies =
            results.map<Movie>((item) => Movie.fromJson(item)).toList();
        if (this.mounted) {
          setState(() {
            _loadingState = LoadingState.DONE;
            _movies.addAll(movies);
            _isLoading = false;
            _pageNumber++;
            _mediaList.data.addAll(data);
          });
        }
      } else {
        throw Exception(json.decode(response.body)['status_message']);
      }
    } catch (e) {
      print('捕捉异常');
      print(e.message);
      _isLoading = false;
      if (_loadingState == LoadingState.LOADING) {
        setState(() {
          _loadingState = LoadingState.ERROR;
          errMsg = e.message.toString();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildMovies(),
    );
  }

  Widget _buildMovies() {
    switch (_loadingState) {
      case LoadingState.LOADING:
        return CircularProgressIndicator();
      case LoadingState.DONE:
        return ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (BuildContext context, int index) {
            if (!_isLoading && index > (_movies.length * 0.7)) {
              _loadMovies();
            }
            return _buildRow(_mediaList.data[index]);
          },
        );
      case LoadingState.ERROR:
        return Text(errMsg);
      default:
        return Container();
    }
  }

  Widget _buildRow(MovieItem movie) {
    return MovieWidget.MovieItem(movie);
  }

  // @override
  // bool get wantKeepAlive => true;
}
