import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class SearchMovies extends MovieEvent {
  final String query;

  const SearchMovies(this.query);

  @override
  List<Object> get props => [query];
}

class LoadPopularMovies extends MovieEvent {
  const LoadPopularMovies();

  @override
  List<Object> get props => [];
}
