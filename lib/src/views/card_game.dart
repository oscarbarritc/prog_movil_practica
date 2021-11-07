import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/games_model.dart';

class CardGameView extends StatefulWidget {
  final GamesModel games;

  const CardGameView({
    Key? key,
    required this.games
    }) : super(key: key);

  @override
  State<CardGameView> createState() => _CardGameViewState();
}

class _CardGameViewState extends State<CardGameView> {
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
      GamesModel juegos;
    
    
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
                image: NetworkImage(widget.games.background_image == null ? 
                'https://blogdigital.es/wp-content/uploads/2015/09/imagen-no-encontrada.jpg' 
                : '${widget.games.background_image}'),
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
                      widget.games.name!,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Flexible(child: widget.games.released == null ? 
                    Text(
                      '  Publicado: ?',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      ): 
                    Text(
                      '  Publicado: '+widget.games.released!,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),

                    MaterialButton(
                      onPressed: (){
                        Navigator.pushNamed(
                          context, 
                          '/gamedetail',
                          arguments: {
                            'id' : widget.games.id,
                            'name' : widget.games.name,
                            'released' : widget.games.released,
                            'metacritic' : widget.games.metacritic,
                            'background_image' : widget.games.background_image,
                            
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