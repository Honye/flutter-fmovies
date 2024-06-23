import 'dart:convert';
import 'dart:io';
import 'package:FMovies/model/repo.dart';
import 'package:FMovies/util/utils.dart';
import 'package:FMovies/widgets/github/repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepoList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => RepoListState();
}

class RepoListState extends State<RepoList> {
  List<Repo> _list = List();
  LoadingState _loadingState = LoadingState.LOADING;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildRepoList(),
    );
  }

  void _getRepoList() async {
    String proxy = HttpClient.findProxyFromEnvironment(Uri.https('www.youtube.com', '/'));
    print('Proxy Env: ===== $proxy =======');
    final response = await http.get(
      Uri.https('api.github.com', '/user/repos'),
      headers: {
        HttpHeaders.authorizationHeader: 'token ec0f4ecd3723aa2c9145903b984856f385125ef5',
        HttpHeaders.acceptHeader: 'application/vnd.github.v3+json'
      }
    );
    if (response.statusCode == 200) {
      final List responseJson = jsonDecode(response.body);
      if (this.mounted) {
        setState(() {
          _list.addAll(responseJson.map((item) => Repo(item)));
          _loadingState = LoadingState.DONE;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getRepoList();
  }

  Widget _buildRepoList() {
    switch (_loadingState) {
      case LoadingState.DONE:
        return ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            var widgets = <Widget>[RepoItem(_list[index])];
            if (index != _list.length - 1) {
              widgets.add(Divider(
                height: 1.0,
                indent: 16,
              ));
            }
            return Column(
              children: widgets,
            );
          }
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