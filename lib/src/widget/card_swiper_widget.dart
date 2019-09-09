import 'package:app_movie/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class CardSwiper extends StatelessWidget {

  final List<Movie> movie;

  CardSwiper({ @required this.movie});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height *0.5,
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child:FadeInImage(
              image: NetworkImage(movie[index].getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
            )
          );
        },
        itemCount: movie.length,
        // pagination: new SwiperPagination(),
        //  control: new SwiperControl(),

      ),
    );
  }
}
