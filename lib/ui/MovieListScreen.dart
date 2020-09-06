import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymovieapp/bloc/movie_bloc.dart';
import 'package:mymovieapp/model/Genre.dart';
import 'package:mymovieapp/model/Movie.dart';
import 'package:mymovieapp/provider/movie_provider.dart';
import 'package:mymovieapp/ui/FavouritsScreen.dart';
import 'package:provider/provider.dart';
import 'GenreTileWidget.dart';
import 'movie_detail.dart';

class MovieListScreen extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListScreen> {
  bool selected = false;
  Set<Movie> _saved = Set<Movie>();
  List<Genre> genres = List<Genre>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).getMoviesFromProvider();
//    MovieBloc().getGenresFromRepo().then((data) {
//      genres = data;
//    });
    Provider.of<MovieProvider>(context, listen: false).getGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies From Api'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: _buildMovies());
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return FavouritesScreen(_saved);
        },
      ),
    );
  }

  Widget _buildMovies() {
    return Consumer<MovieProvider>(
        builder: (BuildContext context, MovieProvider movies, Widget child) =>
            ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: movies.movieList.length,
                itemBuilder: (_, i) {
                  if (i.isOdd) {
                    return Divider();
                  }
                  final int index = i ~/ 2;
                  return _buildRow(movies.movieList[index]);
                }));
  }

  Widget _buildRow(Movie movie) {
    bool alreadySaved = _saved.contains(movie);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MovieDetail(movie))),
          leading: Hero(
            tag: "poster_" + movie.posterPath,
            child: Image.network(
                "https://image.tmdb.org/t/p/w92" + movie.posterPath),
          ),
          title: Text(
            movie.title,
            style: _biggerFont,
          ),
          subtitle: Text(
            'Release Date : ${movie.releaseDate}',
          ),
          trailing: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                  if (alreadySaved) {
                    _saved.remove(movie);
                  } else {
                    _saved.add(movie);
                  }
                });
              },
              child: AnimatedContainer(
                width: alreadySaved ? 30 : 25,
                height: alreadySaved ? 30 : 25,
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 1),
                child: Icon(
                  alreadySaved ? Icons.star : Icons.star_border,
                  color: alreadySaved ? Colors.amber : null,
                  size: alreadySaved ? 30 : 25,
                ),
              )),
//          onTap: () {
//            setState(() {
//              if (alreadySaved) {
//                _saved.remove(movie);
//              } else {
//                _saved.add(movie);
//              }
//            });
//          },
        ),
        SizedBox(
          height: 60.0,
          child: Consumer<MovieProvider>(
            builder:
                (BuildContext context, MovieProvider movies, Widget child) =>
                    ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: movie.genreIds
                  .map((genreId) =>
                      GenreTile(getGenreName(genreId, movies.genreList)))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }

  String getGenreName(int id, List<Genre> gen) {
    Genre g = gen.firstWhere((item) => item.id == id);
    return g.name;
  }
}
