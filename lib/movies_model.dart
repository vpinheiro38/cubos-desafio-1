import 'package:cubos_desafio_1/api.dart';
import 'movie.dart';

class MoviesModel {
  Future<List<Movie>> _movies;

  Future<List<Movie>> get movies => _movies;

  fetchMovies() {
    _movies = API.fetchMovies();
  }
}