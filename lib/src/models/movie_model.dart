// To parse this JSON data, do
//
//     final answer = answerFromJson(jsonString);
class Movies{
  List<Movie> items = new List();

  Movies();
  Movies.fromJsonList( List<dynamic>jsonList){
   if(jsonList==null)return;

   for (var item in jsonList){
     final movie = Movie.fromJsonMap(item);
     items.add(movie);
   }
  }
}


class Movie {
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  DateTime releaseDate;

  Movie({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json){
    voteCount       = json['vote_count'];
    id              = json['id'];
    video           = json['video'];
    voteAverage     = json['vote_average']    /1;
    title           = json['title'];
    popularity      = json['popularity']      /1;
    posterPath      = json['poster_path'];
    originalTitle   = json['original_title'];
    genreIds        = json['genre_id'].cast   <int>();
    backdropPath    = json['blackdrop_path'];
    adult           = json['adult'];
    overview        = json['overview'];
    releaseDate      = json['release_date'];

  }

  getPosterImg(){
    if(posterPath == null) {
       return 'https://www.eecs.utk.edu/wp-content/uploads/2016/02/Googe_EECS.jpg';
    }
    else {
      return'https://image.tmdb.org/t/p/w185_and_h278_bestv2/$posterPath';
    }
  }

}
