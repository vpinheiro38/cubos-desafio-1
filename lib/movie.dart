import 'dart:developer';

class Movie {
  String title;
  String releasedDate;
  String posterUrl;

  Movie(this.title, this.releasedDate, this.posterUrl);

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    releasedDate = json['release_date'];
    posterUrl = 'https://image.tmdb.org/t/p/w300${json['poster_path']}';
  }
}
