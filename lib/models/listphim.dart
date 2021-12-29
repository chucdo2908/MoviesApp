class Listphim{
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  Listphim({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount
  });

  factory Listphim.fromJson(Map<String, dynamic> json){
    return Listphim(
      adult : json['adult'],
      backdropPath : json['backdrop_path'],
      genreIds : json['genre_ids'].cast<int>(),
      id : json['id'],
      originalLanguage : json['original_language'],
      originalTitle : json['original_title'],
      overview : json['overview'],
      popularity : json['popularity'],
      posterPath : json['poster_path'],
      releaseDate : json['release_date'],
      title : json['title'],
      video : json['video'],
      voteAverage : json['vote_average'],
      voteCount : json['vote_count'],
    );
  }

}