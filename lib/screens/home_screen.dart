import 'package:cinebox/models/movie_home_model.dart';
import 'package:cinebox/service/api_service.dart';
import 'package:cinebox/widgets/default_movies.dart';
import 'package:cinebox/widgets/search_results.dart';
import 'package:flutter/material.dart';
import '../widgets/movie_search_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  String searchQuery = "";

  void onSearch(String query) async {
    if(query == ""){
      setState(() {
        isSearching = false;
      });
    }
  }

  void onTap(String movieName) async {
    setState(() {
      isSearching = true;
      searchQuery = movieName;
    });
    return;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10141E),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Center(child: Text("CineBox 🎬", style: TextStyle(color: Colors.white, fontSize: 35))),
            const SizedBox(height: 30),
            MovieSearchTextfield(
              onChanged: (valueChanged) => onSearch(valueChanged),
              onTap: (movieName) => onTap(movieName),
            ),
            const SizedBox(height: 25),
            isSearching ?
              SearchResults(movieName: searchQuery,):
              const DefaultMovies(),
          ],
        ),
      ),
    );
  }
}
