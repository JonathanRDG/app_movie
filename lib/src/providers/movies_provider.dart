import 'dart:convert';

import 'package:app_movie/src/models/movie_model.dart';
import 'package:http/http.dart'as http;

class MoviesProvider {
  String _apikey = '6e04ae00c43accbc2a729b75da11b0cf';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _page = '1';

  Future<List<Movie>>getInTeaters() async{
    final url = Uri.http(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language' : _language,
      'page'   : _page

    });
    final answ = await http.get(url);
    final decodedData = json.decode(answ.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    print(movies.items[0]);
    return[];
  }
}