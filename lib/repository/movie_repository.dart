import 'package:mymovieapp/api-providers/movies_api.dart';
import 'package:mymovieapp/model/Genre.dart';
import 'package:mymovieapp/model/Movie.dart';

class MovieRepository
{
  Future<List<Movie>> getMovies() async{
    return await MoviesApi().fetchMoviesOnline();
  }

  Future<List<Genre>> getGenre() async{
    return await MoviesApi().getGenres();
  }
}