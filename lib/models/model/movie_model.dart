class Movie {
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;

  Movie({
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'No Title',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
      overview: json['overview'] ?? '',
    );
  }
}
