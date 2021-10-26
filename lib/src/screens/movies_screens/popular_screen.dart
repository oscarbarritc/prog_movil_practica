import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/views/card_popular.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apipopular;

  @override
  void initState() {
    super.initState();
    apipopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Popular Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favoritas');
            },
            icon: Icon(Icons.favorite),
          )
        ],
      ),
      body: FutureBuilder(
        future: apipopular!.getAllPopular(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PopularMoviesModel>?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error en la peticion'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listPopularMovies(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? movies) {
    return ListView.separated(
        itemBuilder: (context, index) {
          PopularMoviesModel popular = movies![index];
          return CardPopularView(popular: popular);
        },
        separatorBuilder: (_, __) => Divider(
              height: 10,
            ),
        itemCount: movies!.length);
  }
}
