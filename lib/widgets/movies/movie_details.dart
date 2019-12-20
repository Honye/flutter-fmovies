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
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: _buildDetails(),
      ),
    );
  }

  Widget _buildDetails() {
    switch (_loadingState) {
      case LoadingState.DONE:
        return _buildScroll();
      case LoadingState.ERROR:
        return Text('Sorry, there was an error loading the data!');
      case LoadingState.LOADING:
        return CircularProgressIndicator();
      default:
        return null;
    }
  }

  Widget _buildScroll() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.title),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.jpg',
                  image: _movieDetails.images['large'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0x88ffc107),
                        Colors.transparent,
                      ],
                      begin: FractionalOffset(0.0, 1.0),
                      end: FractionalOffset(0.0, 0.0),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(_movieDetails.durations.join('/') + ' '),
                        Text(_movieDetails.genres.join('/')),
                      ],
                    ),
                    Row(children: <Widget>[
                      Text(_movieDetails.pubdates.join('/') + ' '),
                      Text(_movieDetails.countries.join('/'))
                    ],)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('剧情简介', 
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 12.0,
                      ),
                    ),
                    Text(_movieDetails.summary),
                  ],
                ),
              )
            ]
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _apiClient.getMovieDetails(widget.id).then((data) {
      setState(() {
        _loadingState = LoadingState.DONE;
        _movieDetails = data;
      });
    }).catchError((error) {
      print('捕捉异常');
      print(error);
      setState(() {
        _loadingState = LoadingState.ERROR;
      });
    });
  }
}
