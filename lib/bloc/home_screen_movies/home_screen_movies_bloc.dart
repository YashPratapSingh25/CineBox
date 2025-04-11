import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_screen_movies_event.dart';
import 'home_screen_movies_state.dart';
import '../../service/api_service.dart';

class HomeScreenMoviesBloc extends Bloc<HomeScreenMoviesEvent, HomeScreenMoviesState> {

  final ApiService apiService = ApiService();

  HomeScreenMoviesBloc() : super(HomeScreenMoviesState.initial()) {
    on<FetchAllMoviesEvent>(_onFetchAllMovies);
  }

  Future<void> _onFetchAllMovies(FetchAllMoviesEvent event, Emitter<HomeScreenMoviesState> emit) async {
    emit(state.copyWith(loading: true));

    try {
      final trending = await apiService.fetchTrendingMovies();
      final action = await apiService.fetchMovies(28);
      final sciFi = await apiService.fetchMovies(878);
      final romance = await apiService.fetchMovies(10749);
      final horror = await apiService.fetchMovies(27);

      emit(state.copyWith(
        loading: false,
        trendingMovies: trending,
        actionMovies: action,
        sciFiMovies: sciFi,
        romanceMovies: romance,
        horrorMovies: horror,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
