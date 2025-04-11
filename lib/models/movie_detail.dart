class MovieDetail{
  String title;
  String overview;
  String tagline;
  String posterPath;
  DateTime releaseDate;
  double rating;
  int peopleRated;
  List <String> genres;
  String imdbId;
  List<String> productionCompanies;
  double budget;
  double revenue;
  double runtime;

  MovieDetail({
    required this.title,
    required this.overview,
    required this.tagline,
    required this.posterPath,
    required this.releaseDate,
    required this.rating,
    required this.peopleRated,
    required this.genres,
    required this.imdbId,
    required this.productionCompanies,
    required this.budget,
    required this.revenue,
    required this.runtime,
  });

  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    return MovieDetail(
      title: map["title"] ?? "",
      overview: map["overview"] ?? "",
      tagline: map["tagline"] ?? "",
      posterPath: map["poster_path"] ?? "",
      releaseDate: DateTime.parse(map["release_date"]),
      rating: map["vote_average"] ?? 0.0,
      peopleRated: map["vote_count"] ?? 0,
      genres: _getGenresName(List<Map<String, dynamic>>.from(map["genres"])),
      imdbId: map["imdb_id"] ?? "",
      productionCompanies: _getCompaniesLogo(List<Map<String, dynamic>>.from(map["production_companies"] ?? [])),
      budget: (map["budget"] ?? 0).toDouble(),
      revenue: (map["revenue"] ?? 0).toDouble(),
      runtime: (map["runtime"] ?? 0).toDouble(),
    );
  }

}

List<String> _getGenresName(List<Map<String, dynamic>> genres){
  return genres.map((genre) {
    return genre["name"] as String;
  },).toList();
}

List<String> _getCompaniesLogo(List<Map<String, dynamic>> companies) {
  return companies
      .map((company) => company["logo_path"],)
      .where((logo_path) => logo_path != null,)
      .cast<String>()
      .toList();
}