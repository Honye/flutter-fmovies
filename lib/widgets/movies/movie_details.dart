import 'package:flutter/material.dart';
import '../../util/utils.dart';
import '../../util/api_client.dart';
import '../../model/movie_details.dart' as DetailsModel;

class MovieDetails extends StatefulWidget {
  MovieDetails(this.id, this.title);

  final String id;
  final String title;

  @override
  State<StatefulWidget> createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetails> {
  final ApiClient _apiClient = ApiClient();
  DetailsModel.MovieDetails _movieDetails;
  LoadingState _loadingState = LoadingState.LOADING;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _buildDetails(),
      ),
    );
  }

  Widget _buildDetails() {
    switch(_loadingState) {
      case LoadingState.DONE:
        return Column(
          children: <Widget>[
            Text(_movieDetails.summary)
          ],
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
    _apiClient.getMovieDetails(widget.id)
      .then((data) {
        setState(() {
          _loadingState = LoadingState.DONE;
          _movieDetails = data;
        });
      })
      .catchError((error) {
        setState(() {
          _loadingState = LoadingState.ERROR;
        });
      });
  }
}