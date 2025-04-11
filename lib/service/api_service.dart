import 'dart:convert';
import 'package:cinebox/models/movie_detail.dart';
import 'package:cinebox/models/movie_home_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService{
  final String _baseUrl = "https://api.themoviedb.org/3";
  final _apiKey = dotenv.env['API_KEY'];

  List <HomeScreenMovieModel> _getMovies(Map<String, dynamic> jsonResponse){
    List<dynamic> results = jsonResponse["results"];
    List<HomeScreenMovieModel> movies = [];

    for (var result in results) {
      if(result is Map<String, dynamic> && result["poster_path"] != null){
        movies.add(HomeScreenMovieModel.fromMap(result));
      }
    }
    return movies;
  }

  Future<List<HomeScreenMovieModel>> fetchTrendingMovies() async {
    final Uri url = Uri.parse("$_baseUrl/movie/popular?language=en-US&page=1");

    final response = await http.get(
      url,
      headers: {
        "accept" : "application/json",
        "Authorization": "Bearer $_apiKey"
      }
    );
    if(response.statusCode != 200){
      return [];
    }

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List <HomeScreenMovieModel> movies = _getMovies(jsonResponse);
    return movies;
  }

  Future <List<HomeScreenMovieModel>> fetchMovies(int categoryId) async {
    final Uri url = Uri.parse("$_baseUrl/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=$categoryId");

    final response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $_apiKey"
        }
    );

    if(response.statusCode != 200) return [];

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    List <HomeScreenMovieModel> movies = _getMovies(jsonResponse);
    return movies;
  }

  Future <List<HomeScreenMovieModel>> searchMovie(String movieName) async {
    final Uri url = Uri.parse("$_baseUrl/search/movie?query=$movieName&include_adult=false&language=en-US&page=1");

    final response = await http.get(
      url,
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer $_apiKey"
      }
    );

    if(response.statusCode != 200) return [];

    Map <String, dynamic> jsonResponse = jsonDecode(response.body);

    List <HomeScreenMovieModel> movies = _getMovies(jsonResponse);
    return movies;
  }

  Future <MovieDetail> fetchMovieDetails(int id) async {
    final Uri url = Uri.parse("$_baseUrl/movie/$id?language=en-US");

    final response = await http.get(
    url,
    headers: {
        "accept": "application/json",
        "Authorization": "Bearer $_apiKey"
    }
    );

    Map <String, dynamic> jsonResponse = jsonDecode(response.body);
    MovieDetail movieDetail = MovieDetail.fromMap(jsonResponse);
    return movieDetail;
  }
}