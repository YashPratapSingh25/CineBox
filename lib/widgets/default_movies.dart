import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_screen_movies/home_screen_movies_bloc.dart';
import '../bloc/home_screen_movies/home_screen_movies_state.dart';
import 'horizontal_scroll.dart';

class DefaultMovies extends StatefulWidget {
  const DefaultMovies({super.key});

  @override
  State<DefaultMovies> createState() => _DefaultMoviesState();
}

class _DefaultMoviesState extends State<DefaultMovies> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenMoviesBloc, HomeScreenMoviesState>(
      builder: (context, state) {
        if (state.loading) {
          return SizedBox(height: 600, child: const Center(child: CircularProgressIndicator()));
        }

        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            const Text("Trending 🔥", style: TextStyle(color: Colors.white, fontSize: 30)),
            const SizedBox(height: 15),
            HorizontalScroll(movies: state.trendingMovies),
            const Text("Action 💣", style: TextStyle(color: Colors.white, fontSize: 30)),
            const SizedBox(height: 15),
            HorizontalScroll(movies: state.actionMovies),
            const Text("Sci-Fi 👽", style: TextStyle(color: Colors.white, fontSize: 30)),
            const SizedBox(height: 15),
            HorizontalScroll(movies: state.sciFiMovies),
            const Text("Romance ❤", style: TextStyle(color: Colors.white, fontSize: 30)),
            const SizedBox(height: 15),
            HorizontalScroll(movies: state.romanceMovies),
            const Text("Horror 👻", style: TextStyle(color: Colors.white, fontSize: 30)),
            const SizedBox(height: 15),
            HorizontalScroll(movies: state.horrorMovies),
          ],
        );
      },
    );
  }
}
