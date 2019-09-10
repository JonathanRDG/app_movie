import 'package:app_movie/src/providers/movies_provider.dart';
import 'package:app_movie/src/widget/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            _swiperTarjet()
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjet() {

    return FutureBuilder(
      future: moviesProvider.getInTeaters(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if (snapshot.hasData)
          {
            return CardSwiper(movie: snapshot.data );
          }
        else
          {
            return Container(
                height: 400.0,
                child: Center(
                    child: CircularProgressIndicator()));
          }

      },
    );
  }
}
