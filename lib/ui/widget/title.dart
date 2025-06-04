import 'package:flutter/material.dart';
import '../../models/model/movie_model.dart';
import '../screens/movie_details_screen.dart';


class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1F1F1F),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: movie.posterPath.isNotEmpty
            ? Image.network(
          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
          fit: BoxFit.cover,
          width: 60,
        )
            : Container(width: 60, color: Colors.grey),
        title: Text(movie.title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          movie.releaseDate,
          style: const TextStyle(color: Colors.white54),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieDetailsPage(movie: movie),
            ),
          );
        },
      ),
    );
  }
}
