import 'package:app_movie/src/providers/movies_provider.dart';
import 'package:app_movie/src/widget/card_swiper_widget.dart';
import 'package:app_movie/src/widget/movie_horizontal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en Cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjet(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjet() {

    return FutureBuilder(
      future: moviesProvider.getInTeaters(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if (snapshot.hasData) {
            return CardSwiper(movie: snapshot.data );
          }
        else {
            return Container(
                height: 400.0,
                child: Center(
                    child: CircularProgressIndicator()));
          }

      },
    );
  }

  Widget _footer(BuildContext context)
  {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context,  AsyncSnapshot<List> snapshot){
              if (snapshot.hasData) {
                //snapshot.data?.forEach( (p) => print(p.title)  );
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopular,
                );
              }
              else {
                return Container(
                    child:Center(
                        child: CircularProgressIndicator()
                    )
                );
              }
              },
          ),
        ],
      ),
    );
  }
}
