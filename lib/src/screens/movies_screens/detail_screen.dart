import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/actors_model.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/models/videos_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/views/card_popular.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ApiPopular? apipopular;

  @override
  Widget build(BuildContext context) {
    apipopular = ApiPopular();
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Opacity(
          opacity: .4,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${movie['posterpath']}'),
                  fit: BoxFit.fill),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Descripcion de Pelicula',
              style: TextStyle(
                  backgroundColor: Colors.cyan,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              movie['overview'],
              style: TextStyle(
                  backgroundColor: Colors.black,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Actores',
              style: TextStyle(
                  backgroundColor: Colors.cyan,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 110,
              child: FutureBuilder(
                  future: apipopular!.getactors(movie['id']),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ActorsModel>?> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error en la peticion'),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.done) {
                        
                        return _listActors(snapshot.data);
                      } else {
                        return CircularProgressIndicator();
                      }
                    }
                  },
                ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Trailers',
              style: TextStyle(
                  backgroundColor: Colors.cyan,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Card(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 15, right: 15),
                child: FutureBuilder(
                  future: apipopular!.getVideo(movie['id']),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<VideosModel>?> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error en la peticion'),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return _listVideos(snapshot.data);
                      } else {
                        return CircularProgressIndicator();
                      }
                    }
                  },
                ),
              ),
            ),
            
          ],
        ),
        
        
      ]//children
    );
  }

  Widget _listVideos(List<VideosModel>? movies) {
    return ListView.separated(
        itemBuilder: (context, index) {
          VideosModel popular = movies![index];
          return CardVideosView(videos: popular);
        },
        separatorBuilder: (_, __) => Divider(
              height: 10,
            ),
        itemCount: movies!.length);
  }

  Widget _listActors(List<ActorsModel>? movies) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => VerticalDivider(
        color: Colors.transparent,
        width: 5,
      ),
      itemCount: movies!.length, 
      itemBuilder: (context,index){
        ActorsModel cast = movies[index];
        return Container(
          child: Column(
            children: <Widget> [
              
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 3,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: cast.profile_path != null ? 'https://image.tmdb.org/t/p/w500/${cast.profile_path}' :
                    'https://upload.wikimedia.org/wikipedia/commons/3/34/PICA.jpg',
                    imageBuilder: (context,imageBuilder){
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100)
                          ),
                          image: DecorationImage(
                            image: imageBuilder,
                            fit: BoxFit.cover
                          ) 
                        ),
                      );
                    },
                    placeholder: (context,url) => Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context,url,error) => Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/activity_indicator.gif'
                          ),
                        ),
                      ),
                    ),
                  ),  
                ),
              ),
              Container(
                child: Flexible(
                  child: Center(
                    child: Text(
                      cast.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'muli',
                        decoration: TextDecoration.none,
                      ),
                
                    ),
                  ),
                ),
              ),
              Container(
                child: Flexible(
                  child: Center(
                    child: Text(
                      cast.character!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'muli',
                        decoration: TextDecoration.none,
                      ),
                
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CardVideosView extends StatelessWidget {
  final VideosModel videos;

  const CardVideosView({
    Key? key,
    required this.videos
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
            Opacity(
              opacity: .5,
              child: Container(
                
                padding: EdgeInsets.only(left: 10),
                height: 60,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        videos.name!,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    
                    MaterialButton(
                      onPressed: (){
                        _launchURL("https://www.youtube.com/watch?v="+ videos.key.toString()); 
                      },
                      child: Icon(Icons.ondemand_video, color: Colors.white,),
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
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo lanzar $url';
    }
  }
}





