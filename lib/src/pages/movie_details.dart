import 'package:app_movie/src/models/movie_model.dart';
import 'package:flutter/material.dart';
class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Text(movie.title),
      ),
    );
  }
}
