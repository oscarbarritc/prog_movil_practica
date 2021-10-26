import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/actors_model.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/models/videos_model.dart';

class ApiPopular {
  Future<List<PopularMoviesModel>?> getAllPopular() async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=500d300f24df95e6280b7ea94ffcd8bd&language=es-MX&page=1');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listPopular =
          popular.map((movie) => PopularMoviesModel.fromMap(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<List<VideosModel>?> getVideo(int movie_id) async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/${movie_id}/videos?api_key=500d300f24df95e6280b7ea94ffcd8bd&language=en-US');

    final response = await http.get(URL);

    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<VideosModel> listVideos =
          popular.map((movie) => VideosModel.fromMap(movie)).toList();
      return listVideos;
    } else {
      return null;
    }
  }

  Future<List<ActorsModel>?> getactors(int movie_id) async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/${movie_id}/credits?api_key=500d300f24df95e6280b7ea94ffcd8bd&language=en-US');

    final response = await http.get(URL);

    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['cast'] as List;
      List<ActorsModel> listActors =
          popular.map((movie) => ActorsModel.fromMap(movie)).toList();
      return listActors;
    } else {
      return null;
    }
  }
}
