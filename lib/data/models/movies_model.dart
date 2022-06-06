class MoviesModel {
  int? id;
  String? title;
  double? voteCount;
  double? vote;
  String? image;
  String? backdrop;
  String? overview;
  DateTime? releaseDate;
  bool? adult;
  MoviesModel({required this.id});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    voteCount = double.parse(json['vote_count'].toString());
    image = json['poster_path'];
    backdrop = json['backdrop_path'];
    vote = double.parse(json['vote_average'].toString());
    releaseDate = DateTime.parse(json['release_date']);
    overview = json['overview'];
    adult = json['adult'];
  }
  Map<String, dynamic> toJson() => {};
}
