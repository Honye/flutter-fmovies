import 'package:flutter/material.dart';
import '../../util/api_client.dart';
import '../../model/media_list.dart';
import './movie_item.dart';
import '../../util/utils.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  MediaList _mediaList = MediaList();
  LoadingState _loadingState = LoadingState.LOADING;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildMovieList(),
    );
  }

  _getMovies() {
    _isLoading = true;
    ApiClient().getInTheaters(
      start: _mediaList.count,
    ).then((data) {
      if (this.mounted) {
        setState(() {
          _mediaList.count += data.count;
          _mediaList.total = data.total;
          _mediaList.data.addAll(data.data);
          _loadingState = LoadingState.DONE;
          _isLoading = false;
        });
      }
    }).catchError((error) {
      print('捕捉异常');
      print(error.message);
      _isLoading = false;
      if (_loadingState == LoadingState.LOADING) {
        setState(() {
          _loadingState = LoadingState.ERROR;
        });
      }
    });
  }

  Widget _buildMovieList() {
    switch (_loadingState) {
      case LoadingState.DONE:
        return ListView.builder(
          itemCount: _mediaList.data.length,
          itemBuilder: (BuildContext context, int index) {
            if (!_isLoading && index > (_mediaList.data.length * 0.7)) {
              _getMovies();
            }
            var widgets = <Widget>[MovieItem(_mediaList.data[index])];
            if (index != _mediaList.data.length - 1) {
              widgets.add(Divider(
                height: 1.0,
                indent: 16,
              ));
            }
            return Column(
              children: widgets,
            );
          },
        );
      case LoadingState.ERROR:
        return Text('Sorry, there was an error loading the data!');
      case LoadingState.LOADING:
        return CircularProgressIndicator();
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getMovies();
  }
}
