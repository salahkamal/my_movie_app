import 'package:flutter/foundation.dart';
import 'package:mymovieapp/model/Genre.dart';
//import 'package:flutter/material.dart';
import 'package:mymovieapp/model/Movie.dart';
import 'package:mymovieapp/repository/movie_repository.dart';

class MovieProvider with ChangeNotifier{
  List<Movie> movieList = <Movie>[];
  List<Genre> genreList = <Genre>[];
  void getMoviesFromProvider() async{
    movieList = await MovieRepository().getMovies();
    notifyListeners();
  }

  void getGenre() async {
    genreList = await MovieRepository().getGenre();
    notifyListeners();
  }

}