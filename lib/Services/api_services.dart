import 'package:demo/Model/Popular_TV_model.dart';
import 'package:demo/Model/TopRated_movies_model.dart';
import 'package:demo/Model/TopRated_tv_model.dart';
import 'package:demo/Model/movie_detail_model.dart';
import 'package:demo/Model/popular_movie_model.dart';
import 'package:http/http.dart' as http;

import '../Model/hot_news_model.dart';
import '../Model/movie_recommended_model.dart';
import '../Model/movie_search_model.dart';
import '../Model/movies_model.dart';
import '../Model/upcoming_movies_model.dart';
import '../common/utils.dart';

var key = "?api_key=$apikey";

class ApiServices {
  Future<MovieNowplaying?> movie() async {
    try {
      const endPoint = "movie/now_playing";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieNowplayingFromJson(response.body);
      } else {
        throw Exception("failed to load movie");
      }
    } catch (e) {
      print("Error featching movies$e");
      return null;
    }
  }

//upcoming movies
  Future<Upcoming?> upcoming() async {
    try {
      const endPoint = "movie/upcoming";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return upcomingFromJson(response.body);
      } else {
        throw Exception("failed to load movie");
      }
    } catch (e) {
      print("Error featching movies$e");
      return null;
    }
  }

  Future<PopularMovie?> popular() async {
    try {
      const endPoint = "movie/popular";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return popularMovieFromJson(response.body);
      } else {
        throw Exception("failed to load movie");
      }
    } catch (e) {
      print("Error featching movies$e");
      return null;
    }
  }

  Future<TopRatedMovie?> topRated() async {
    try {
      const endPoint = "movie/top_rated";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return topRatedMovieFromJson(response.body);
      } else {
        throw Exception("failed to load movie");
      }
    } catch (e) {
      print("Error featching movies$e");
      return null;
    }
  }

  Future<PopularTv?> popularTv() async {
    try {
      const endPoint = "tv/popular";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return popularTvFromJson(response.body);
      } else {
        throw Exception("failed to load Movie");
      }
    } catch (e) {
      print("Error Featching movies $e");
      return null;
    }
  }

  Future<TopRatedTv?> topRatedTv() async {
    try {
      const endPoint = "tv/top_rated";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return topRatedTvFromJson(response.body);
      } else {
        throw Exception("failed to load Movie");
      }
    } catch (e) {
      print("Error Featching movies $e");
      return null;
    }
  }

  Future<MovieDetails?> movieDetail(int movieID) async {
    try {
      final endPoint = "movie/$movieID";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieDetailsFromJson(response.body);
      } else {
        throw Exception("failed to load Movie");
      }
    } catch (e) {
      print("Error Featching movies $e");
      return null;
    }
  }

  Future<MovieRecom?> movieRec(int movieID) async {
    try {
      final endPoint = "movie/$movieID/recommendations";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieRecomFromJson(response.body);
      } else {
        throw Exception("failed to load Movie");
      }
    } catch (e) {
      print("Error Featching movies $e");
      return null;
    }
  }

  Future<MovieSearchBox?> movieSearch(String query) async {
    try {
      final endPoint = "search/movie?query=$query";
      final apiUrl = "$baseUrl$endPoint";
      final response = await http.get(Uri.parse(apiUrl), headers: {
        "Authorization":
            "bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOWZkMGE1MjU3NWQ4YzU2NmViMjYwMDMwYzJjZmU5MCIsIm5iZiI6MTc2ODkxNjM3OS4yMzgwMDAyLCJzdWIiOiI2OTZmODU5YmI3ZGI2ZmQzYWVhYmQxN2IiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ZTQkiM5fyAf5yuoflFAHqEllSZKJS8PIVn83FLhp_20"
      });
      if (response.statusCode == 200) {
        return movieSearchBoxFromJson(response.body);
      } else {
        throw Exception("failed to load Movie");
      }
    } catch (e) {
      print("Error Featching movies $e");
      return null;
    }
  }

  Future<HotTopic?> hotTopics() async {
    try {
      final endPoint = "trending/all/day";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return hotTopicFromJson(response.body);
      } else {
        throw Exception("failed to load Movie");
      }
    } catch (e) {
      print("Error Featching movies $e");
      return null;
    }
  }
}
