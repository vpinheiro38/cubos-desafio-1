import 'package:cubos_desafio_1/movies_model.dart';

import 'movie.dart';

class MoviesController {
  final model = MoviesModel();

  Future<List<Movie>> get movies => model.movies;

  loadMovies() {
    model.fetchMovies();
  }
}