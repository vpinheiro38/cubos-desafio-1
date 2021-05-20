import 'package:cubos_desafio_1/api.dart';
import 'package:cubos_desafio_1/movie.dart';
import 'package:cubos_desafio_1/movies_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FetchMovies should return valid Movies', () {
    final model = MoviesModel(api: MockAPI());

    model.fetchMovies();

    expect(model.movies, completion(isNotNull));
    model.movies.then((movies) {
      expect(movies.length, 2);
      expect(movies[0].title, 'Primeiro');
      expect(movies[1].title, 'Segundo');
    });
  });
}

class MockAPI extends API {
  @override
  Future<List<Movie>> fetchMovies() async {
    final movies = [
      Movie('Primeiro', '00/00/0000', 'null'),
      Movie('Segundo', '00/00/0000', 'null')
    ];
    return movies;
  }
}
