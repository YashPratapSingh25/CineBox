import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';

class HorizontalScroll extends StatefulWidget {
  final List movies;
  const HorizontalScroll({super.key, required this.movies});

  @override
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(movieId: movie.id),)),
              child: Column(
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                    height: 200,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: Text(
                      movie.title,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
