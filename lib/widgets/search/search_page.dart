import 'package:flutter/material.dart';
import '../../util/api_client.dart';
import '../../util/utils.dart';
import '../../model/media_list.dart';
import '../movies/movie_item.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _keywords = '';
  final TextEditingController _controller = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  MediaList _mediaList = MediaList();
  LoadingState _loadingState = LoadingState.WAITING;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.black,),
            hintText: '关键词搜索',
            suffixIcon: _keywords.length > 0
              ? IconButton(
                icon: Icon(Icons.clear, color: Colors.grey[850],),
                onPressed: _clearText,
              ) : null,
          ),
          onChanged: _handleInputChange,
          autofocus: true,
          onSubmitted: _submitText,
          textInputAction: TextInputAction.search,
        ),
      ),
      body: Center(
        child: _buildList(),
      ),
    );
  }

  _clearText() {
    _controller.clear();
    setState(() {
      _keywords = '';
    });
  }

  _handleInputChange(String value) {
    setState(() {
      _keywords = value;
    });
  }

  _submitText(String value) {
    setState(() {
      _mediaList.count = 0;
      _mediaList.total = 0;
      _mediaList.data.clear();
    });
    _searchMovies();
  }

  _searchMovies() {
    _isLoading = true;
    _apiClient.searchMovie(
      _keywords,
      start: _mediaList.count,
    ).then((MediaList data) {
        if (this.mounted) {
          setState(() {
            _mediaList.count += data.count;
            _mediaList.total = data.total;
            _mediaList.data.addAll(data.data);
            _loadingState = LoadingState.DONE;
            _isLoading = false;
          });
        }
      })
      .catchError((error) {
        print('捕捉异常');
        print(error);
        _isLoading = false;
        if (_loadingState == LoadingState.LOADING) {
          setState(() {
            _loadingState = LoadingState.ERROR;
          });
        }
      });
  }

  Widget _buildList() {
    switch(_loadingState) {
      case LoadingState.DONE:
        if (_mediaList.data.length == 0) {
          return Text('No matched!');
        }
        return ListView.builder(
          itemCount: _mediaList.data.length,
          itemBuilder: (BuildContext context, int index) {
            if (!_isLoading && index > (_mediaList.data.length * 0.7)) {
              _searchMovies();
            }
            var widgets = <Widget>[MovieItem(_mediaList.data[index])];
            if (index != _mediaList.data.length -1) {
              widgets.add(Divider(
                height: 1.0,
                indent: 16,
              ));
            }
            return Column(children: widgets,);
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
}