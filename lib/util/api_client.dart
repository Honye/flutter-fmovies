import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/media_list.dart';
import '../model/movie_item.dart';
import '../model/movie_details.dart';

class ApiClient {
	static final _client = ApiClient._internal();
	final String host = 'api.douban.com';

	ApiClient._internal();

	factory ApiClient() => _client;

	Future<dynamic> _getJson(String path, [Map<String, String> params]) {
		Map<String, String> map = { 'apikey': '0b2bdeda43b5688921839c8ecb20399b' };
    if (params != null && params.isNotEmpty) {
      map.addAll(params);
    }
		return http.get(
			Uri.https(host, path, map)
		).then((response) {
			if (response.statusCode == 200) {
				return json.decode(response.body);
			} else {
				throw Exception(json.decode(response.body)['msg']);
			}
		});
	}

	// 影院热映
	Future<MediaList> getInTheaters({ int start: 0, int count: 10 }) {
		return _getJson('v2/movie/in_theaters', {
			'start': start.toString(),
			'count': count.toString(),
		}).then((body) {
			MediaList mediaList = MediaList();
			mediaList.count = body['count'];
			mediaList.total = body['total'];
			mediaList.data = body['subjects'].map<MovieItem>((item) => MovieItem(item)).toList();
			return mediaList;
		});
	}

  /// 搜索影视
  Future<MediaList> searchMovie(String keywords, { int start: 0, int count: 10 }) {
    return _getJson('v2/movie/search', {
      'q': keywords,
      'start': start.toString(),
      'count': count.toString(),
    }).then((body) {
      MediaList mediaList = MediaList();
      mediaList.count = body['count'];
      mediaList.total = body['total'];
      mediaList.data = body['subjects'].map<MovieItem>((item) => MovieItem(item)).toList();
      return mediaList;
    });
  }

  /// 影视详情
  Future<MovieDetails> getMovieDetails(String id) {
    return _getJson('v2/movie/subject/$id').then((body) => MovieDetails(body));
  }
}
