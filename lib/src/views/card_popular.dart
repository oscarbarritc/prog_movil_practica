import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/popular_movies_model.dart';

class CardPopularView extends StatefulWidget {
  final PopularMoviesModel popular;

  const CardPopularView({
    Key? key,
    required this.popular
    }) : super(key: key);

  @override
  State<CardPopularView> createState() => _CardPopularViewState();
}

class _CardPopularViewState extends State<CardPopularView> {
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
      PopularMoviesModel pelicula;
    
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, 5),
            blurRadius: 2.5
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children:[
            
            Container(
              child: FadeInImage(
                placeholder: AssetImage('assets/activity_indicator.gif'),
                image: NetworkImage('https://image.tmdb.org/t/p/w500/${widget.popular.backdropPath}'),
                fadeInDuration: Duration(milliseconds: 200),
              ),
            ),
            Opacity(
              opacity: .5,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 60,
                color: Colors.black,
                child: Row( 
                  children: <Widget>[
                    Flexible(child: Text(
                      widget.popular.title!,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),),
                    
                    MaterialButton(
                      onPressed: () async{
                        PopularMoviesModel peli = PopularMoviesModel(
                          title: widget.popular.title,
                          backdropPath: widget.popular.backdropPath
                        );
                        pelicula = await _databaseHelper.getfmovie(peli.title!);
                        if (pelicula.title == null) {
                          _databaseHelper.insertfavorite(peli.toMap()).then((value) {
                            if (value > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('La Pelicula ${widget.popular.title} se agrego a favoritas')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('La solicitud no se completo')));
                            }
                          });
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('La Pelicula ya esta en la lista de favoritas')));
                        }  
                      },
                      
                      child: Icon(Icons.favorite, color: Colors.white),
                    ),
                    MaterialButton(
                      onPressed: (){
                        Navigator.pushNamed(
                          context, 
                          '/detail',
                          arguments: {
                            'id' : widget.popular.id,
                            'title' : widget.popular.title,
                            'overview' : widget.popular.overview,
                            'posterpath' : widget.popular.posterPath,
                            'backdropPath' : widget.popular.backdropPath
                          }
                        );
                      },
                      child: Icon(Icons.chevron_right, color: Colors.white,),
                    )
                    
                  ],
                ),
              ),
            )
          ] 
        ),
      )
    );

  }

}