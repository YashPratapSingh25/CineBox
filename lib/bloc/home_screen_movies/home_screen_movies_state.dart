import '../../models/movie_home_model.dart';

class HomeScreenMoviesState {
  final bool loading;
  final String? error;
  final List<HomeScreenMovieModel> trendingMovies;
  final List<HomeScreenMovieModel> actionMovies;
  final List<HomeScreenMovieModel> sciFiMovies;
  final List<HomeScreenMovieModel> romanceMovies;
  final List<HomeScreenMovieModel> horrorMovies;

  HomeScreenMoviesState({
    required this.loading,
    required this.error,
    required this.trendingMovies,
    required this.actionMovies,
    required this.sciFiMovies,
    required this.romanceMovies,
    required this.horrorMovies,
  });

  factory HomeScreenMoviesState.initial() {
    return HomeScreenMoviesState(
      loading: false,
      error: null,
      trendingMovies: [],
      actionMovies: [],
      sciFiMovies: [],
      romanceMovies: [],
      horrorMovies: [],
    );
  }

  HomeScreenMoviesState copyWith({
    bool? loading,
    String? error,
    List<HomeScreenMovieModel>? trendingMovies,
    List<HomeScreenMovieModel>? actionMovies,
    List<HomeScreenMovieModel>? sciFiMovies,
    List<HomeScreenMovieModel>? romanceMovies,
    List<HomeScreenMovieModel>? horrorMovies,
  }) {
    return HomeScreenMoviesState(
      loading: loading ?? this.loading,
      error: error,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      actionMovies: actionMovies ?? this.actionMovies,
      sciFiMovies: sciFiMovies ?? this.sciFiMovies,
      romanceMovies: romanceMovies ?? this.romanceMovies,
      horrorMovies: horrorMovies ?? this.horrorMovies,
    );
  }
}
