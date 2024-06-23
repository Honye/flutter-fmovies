import 'package:flutter/material.dart';
import '../movies.dart';
import './movies/movie_list.dart' as CMovieList;
import './github/repo_list.dart';
import '../hello.dart';
import './search/search_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PageController _pageController;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('FMovies',
            style: TextStyle(
              fontFamily: 'Playball',
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search,
                color: Colors.black,
              ),
              onPressed: _pushSearch,
            ),
          ],
      ),
      body: PageView(
        children: <Widget>[
          RepoList(),
          // CMovieList.MovieList(),
          // MovieList(),
          HelloWords(),
        ],
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (int index) {
            setState(() {
                _selectedIndex = index;
            });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: 'Repos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fingerprint), label: 'Store'),
        ],
        currentIndex: _selectedIndex,
        onTap: (int page) {
          _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  _pushSearch() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchPage(),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
