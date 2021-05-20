import 'dart:convert';
import 'dart:developer';

import 'package:cubos_desafio_1/movie.dart';
import 'package:http/http.dart' as http;

class API {
  const API();

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.https('api.themoviedb.org',
        '/3/movie/upcoming', {'api_key': 'a5bc05fb630c9b7fdc560033345fa13e'}));

    if (response.statusCode == 200) {
      final moviesJson = jsonDecode(response.body)['results'] as List;

      return moviesJson.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      return Future.error("Movies not found");
    }
  }
}
