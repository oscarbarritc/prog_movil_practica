import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/actors_model.dart';
import 'package:practica2/src/models/games_model.dart';
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

  //games
  Future<List<GamesModel>?> getgames(int page) async {
    var URL = Uri.parse(
        'https://api.rawg.io/api/games?key=23573e29b12e4599b450cb446125983d&page=${page}');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<GamesModel> listPopular =
          popular.map((movie) => GamesModel.fromMap(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<List<GamesModel>?> getgamessearch(String search, int page) async {
    var URL = Uri.parse(
        'https://api.rawg.io/api/games?key=23573e29b12e4599b450cb446125983d&search=${search}&page=${page}');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<GamesModel> listPopular =
          popular.map((movie) => GamesModel.fromMap(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<int?> getgamessearchcount(String search, int page) async {
    var URL = Uri.parse(
        'https://api.rawg.io/api/games?key=23573e29b12e4599b450cb446125983d&search=${search}&page=${page}');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['count'] as int;
      print('se regresa el numero de la api');
      return popular;
    } else {
      return null;
    }
  }

  Future<List<GamesModel>?> getpublisher(int id) async {
    var URL = Uri.parse(
        'https://api.rawg.io/api/games/${id}?key=23573e29b12e4599b450cb446125983d');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['publishers'] as List;
      List<GamesModel> listPopular =
          popular.map((movie) => GamesModel.fromMapPublisher(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<List<GamesModel>?> getgamedevelopers(int id) async {
    var URL = Uri.parse(
        'https://api.rawg.io/api/games/${id}?key=23573e29b12e4599b450cb446125983d');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['developers'] as List;
      List<GamesModel> listPopular =
          popular.map((movie) => GamesModel.fromMapDevelopers(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<List<GamesModel>?> getgamegenres(int id) async {
    var URL = Uri.parse(
        'https://api.rawg.io/api/games/${id}?key=23573e29b12e4599b450cb446125983d');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['genres'] as List;
      List<GamesModel> listPopular =
          popular.map((movie) => GamesModel.fromMapgenres(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<List<String>?> getgameplataforms(int id) async {
    var URL = Uri.parse(
        'https://api.rawg.io/api/games/${id}?key=23573e29b12e4599b450cb446125983d');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['platforms'] as List;
      List<String> listPopular = [];
      for (int i = 0; i < popular.length; i++) {
        listPopular.add(popular[i]["platform"]["name"]);
      }
      return listPopular;
    } else {
      return null;
    }
  }

  Future<String?> getdescription(int id) async {
    var URL = Uri.parse(
        'https://api.rawg.io/api/games/${id}?key=23573e29b12e4599b450cb446125983d');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['description'] as String;
      return popular;
    } else {
      return null;
    }
  }
}
