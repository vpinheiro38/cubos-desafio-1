import 'package:cubos_desafio_1/api.dart';
import 'movie.dart';

class MoviesModel {
  final API api;
  Future<List<Movie>> _movies;

  MoviesModel({this.api: const API()});

  Future<List<Movie>> get movies => _movies;

  fetchMovies() {
    _movies = api.fetchMovies();
  }
}
