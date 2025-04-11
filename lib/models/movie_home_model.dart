class HomeScreenMovieModel{
  int id;
  String posterPath;
  String title;

  HomeScreenMovieModel({
    required this.id,
    required this.posterPath,
    required this.title,
  });

  factory HomeScreenMovieModel.fromMap(Map<String, dynamic> map){
    return HomeScreenMovieModel(
      id: map["id"],
      posterPath: map["poster_path"],
      title: map["title"],
    );
  }
}