import 'package:flutter/material.dart';
import 'package:cinebox/models/movie_detail.dart';
import 'package:cinebox/service/api_service.dart';

class DetailScreen extends StatelessWidget {
  final int movieId;

  const DetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<MovieDetail>(
        future: ApiService().fetchMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Error loading data", style: TextStyle(color: Colors.white)));
          }

          final movie = snapshot.data!;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.6),
                  colorBlendMode: BlendMode.darken,
                ),
              ),

              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        movie.title,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      if (movie.tagline.isNotEmpty)
                        Text(
                          movie.tagline,
                          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white70),
                        ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          _infoBadge("⭐ ${movie.rating.toStringAsFixed(1)}"),
                          const SizedBox(width: 10),
                          _infoBadge("${movie.peopleRated} Reviews"),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Wrap(
                        spacing: 8,
                        children: movie.genres.map((genre) => _genreChip(genre)).toList(),
                      ),

                      const SizedBox(height: 20),

                      // Overview
                      const Text(
                        "Overview",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview,
                        style: const TextStyle(fontSize: 16, color: Colors.white70),
                      ),

                      const SizedBox(height: 20),

                      // Other Details
                      _detailRow("Release Date", "${movie.releaseDate.toLocal()}".split(' ')[0]),
                      _detailRow("Runtime", "${movie.runtime} mins"),
                      _detailRow("Budget", "\$${movie.budget.toStringAsFixed(0)}"),
                      _detailRow("Revenue", "\$${movie.revenue.toStringAsFixed(0)}"),

                      const SizedBox(height: 30),

                      // Production Companies
                      if (movie.productionCompanies.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Production Companies",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movie.productionCompanies.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/w200${movie.productionCompanies[index]}",
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _infoBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _genreChip(String genre) {
    return Chip(
      label: Text(genre),
      backgroundColor: Colors.deepPurple,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.white70))),
        ],
      ),
    );
  }
}
