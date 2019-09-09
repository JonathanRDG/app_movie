import 'dart:convert';
import 'package:app_movie/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieProvider {
  String _apikey      = '6e04ae00c43accbc2a729b75da11b0cf';
  String _url         = 'api.themoviedb.org';
  String _languaje    = 'es-ES';

  Future<List<Movie>> getinmovieteaters() async{

    final url = Uri.https(_url,'3/movie/now_playing',{
      'api_key'  : _apikey,
      'language' : _languaje
    });
    final ans = await http.get(url);
    final decodedData = json.decode(ans.body);
   // print(decodedData);
    final movies = new Movies.fromJsonList(decodedData['results']);
    print(movies);
    return movies.items;

  }

}