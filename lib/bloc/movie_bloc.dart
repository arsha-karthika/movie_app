import 'package:bloc/bloc.dart';

import '../models/repository/movie_repo.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc(this.repository) : super(MovieInitial()) {
    on<SearchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await repository.searchMovies(event.query);
        if (movies.isEmpty) {
          emit(const MovieError("No results found."));
        } else {
          emit(MovieLoaded(movies));
        }
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });

    on<LoadPopularMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await repository.fetchPopularMovies();
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}
