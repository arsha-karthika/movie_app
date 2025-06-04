import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie_bloc.dart';
import '../../bloc/movie_event.dart';
import '../../bloc/movie_state.dart';
import '../../models/model/movie_model.dart';
import '../widget/title.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key, required List defaultMovies});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(LoadPopularMovies());
  }

  void _onSearch(String value) {
    if (value.trim().isEmpty) {
      context.read<MovieBloc>().add(LoadPopularMovies());
    } else {
      context.read<MovieBloc>().add(SearchMovies(value.trim()));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.movie_outlined,color: Colors.white,),
        title:  Text("Movie Hunt", style: TextStyle(color: Colors.red, fontSize: 22,fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("What to Watch?", style: TextStyle(color: Colors.white70, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onChanged: _onSearch,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                hintText: "Search for a movie",
                hintStyle: const TextStyle(color: Colors.white38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    controller.clear();
                    _onSearch('');
                  },
                )
                    : const Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  final movies = state.movies;

                  if (controller.text.trim().isEmpty) {
                    return _buildPopularGrid(movies);
                  } else {
                    return _buildSearchList(movies);
                  }
                } else if (state is MovieError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
                }

                return const Center(
                  child: Text("Search for a movie", style: TextStyle(color: Colors.white54)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchList(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (_, index) => MovieTile(movie: movies[index]),
    );
  }

  Widget _buildPopularGrid(List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Popular Movies", style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (_, index) => MovieTile(movie: movies[index]),
          ),
        ),
      ],
    );
  }
}



