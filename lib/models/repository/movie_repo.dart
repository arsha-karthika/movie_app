import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../ui/widget/constants/constants.dart';
import '../model/movie_model.dart';

class MovieRepository {
  final http.Client client;

  MovieRepository(this.client);

  Future<List<Movie>> searchMovies(String query) async {
    final response = await client.get(Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=$TMDB_API_KEY&query=$query',
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await client.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=$TMDB_API_KEY',
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }
}
