import './movie_item.dart';

class MediaList {
    int count = 0;
    int total = 0;
    List<MovieItem> data = List<MovieItem>();

    MediaList();

    Map toJson() => {
        'count': count,
        'total': total,
        'data': data.map((item) => item.toJson()),
    };

    // factory MediaList(Map jsonMap) =>
    //     MediaList._fromJson(jsonMap);

    // MediaList._fromJson(Map jsonMap)
    //     : count = jsonMap['count'],
    //       total = jsonMap['total'],
    //       data = jsonMap['subjects'].map<MovieItem>((item) => MovieItem(item)).toList();
}