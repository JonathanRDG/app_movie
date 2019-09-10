class Movies{
  List<Movie> items = new List();
      Movies();
      Movies.fromJsonList(List<dynamic>jsonList){
        if (jsonList == null) return;

        for(var item in jsonList) {
        final movie = new Movie.fromJsonMap(item);
        items.add(movie);
        }
      }
}

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;git
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,

  });
  Movie.fromJsonMap(Map<String, dynamic> json){

    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];

  }
}