import 'package:cinebox/models/movie_home_model.dart';
import 'package:cinebox/screens/detail_screen.dart';
import 'package:cinebox/service/api_service.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  final String movieName;
  const SearchResults({super.key, required this.movieName});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().searchMovie(widget.movieName),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const SizedBox(
            height: 600,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if(snapshot.hasError){
          return const Center(
            child: Text("Error Occurred"),
          );
        }


        final List<HomeScreenMovieModel>? searchResults = snapshot.data;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 600,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.66,
                ),
                itemCount: searchResults?.length,
                itemBuilder: (context, index) {
                  final movie = searchResults?[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(movieId: movie.id),)),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500/${movie?.posterPath}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie!.title,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

}
