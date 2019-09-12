import 'package:app_movie/src/models/actors_model.dart';
import 'package:app_movie/src/models/movie_model.dart';
import 'package:app_movie/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xff222222),
        body: CustomScrollView(
          slivers: <Widget>[
            _crateAppbar(movie),
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 10.0),
                    _posterTitle(context, movie),
                    _description(movie),
                    _createCast(movie)

                  ]
              ),
            )
          ],
        )
    );
  }

  Widget _crateAppbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(movie.title,
            style: TextStyle(color: Colors.white,fontSize: 16.0)
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()  ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image:NetworkImage(movie.getPosterImg() ),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*.05,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: TextStyle(
                  color: Colors.white
                )),
                Text(movie.originalTitle, style: TextStyle(
                    color: Colors.white)),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(), style: TextStyle(
                        color: Colors.white))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      style: TextStyle(
      color: Colors.white)
      ),
    );

  }

  Widget _createCast(Movie movie) {
    final moviProvider = new MoviesProvider();

    return FutureBuilder(
      future: moviProvider.getCast(movie.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){

        if (snapshot.hasData){
          return _createActorsPageView(snapshot.data);
        }
        else
          {
            return Center(
              child: CircularProgressIndicator()  );
          }
        },
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {

    return SizedBox(
    height: 200.0,
    child: PageView.builder(
      controller: PageController(
        viewportFraction: 0.3,
        initialPage: 1,
      ),
      itemCount: actors.length,
      itemBuilder: (context,i) => _actorCard(actors[i]),

    ),
    );
  }

  Widget _actorCard(Actor actor){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPhoto()  ),
              placeholder: AssetImage('assets/img/loading.gif'),
              height: 150.0,
              fit: BoxFit.cover
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
            color: Colors.white
          ))
        ],
      ),
    );
  }
}
