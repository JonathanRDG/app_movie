import 'dart:async';
import 'dart:convert';
import 'package:app_movie/src/models/movie_model.dart';
import 'package:http/http.dart'as http;

class MoviesProvider {
  String _apikey = '6e04ae00c43accbc2a729b75da11b0cf';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _page = '1';
  int _pupularPage = 0;
  bool _loading = false;

  List<Movie>_popular =  new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>)get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Future<List<Movie>>getInTeaters() async{
    final url = Uri.http(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language' : _language,
      'page'   : _page

    });
    return await _processAnswer(url);
  }

  Future<List<Movie>>getPopular() async {
    if(_loading) return [];

    _loading = true;
    _pupularPage++;
    final url = Uri.http(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language' : _language,
      'page' : _pupularPage.toString()
    });

    final answ = await _processAnswer(url);
    _popular.addAll(answ);
    popularSink(_popular);
    _loading= false;
    return answ;

  }

  Future<List<Movie>>_processAnswer(Uri url) async{
    final answ = await http.get(url);
    final decodedData = json.decode(answ.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }
}