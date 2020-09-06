import 'package:mymovieapp/model/Genre.dart';
import 'package:mymovieapp/model/Movie.dart';
import 'package:mymovieapp/repository/movie_repository.dart';

class MovieBloc
{
  Future<List<Movie>> getMoviesFromRepo () async
  {
    return await MovieRepository().getMovies();
  }

  Future<List<Genre>> getGenresFromRepo () async
  {
    return await MovieRepository().getGenre();
  }
}