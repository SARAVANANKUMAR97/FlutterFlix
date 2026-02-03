import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/Services/api_services.dart';
import 'package:demo/common/utils.dart';
import 'package:demo/screens/movie_screen_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/hot_news_model.dart';

class hotTopic extends StatefulWidget {
  const hotTopic({super.key});

  @override
  State<hotTopic> createState() => _hotTopicState();
}

class _hotTopicState extends State<hotTopic> {
  final ApiServices apiServices = ApiServices();
  late Future<HotTopic?> hotTopic;

  @override
  void initState() {
    super.initState();
    hotTopic = apiServices.hotTopics();
  }

  @override
  Widget build(BuildContext context) {
    String getShortName(String name) {
      return name.length > 3 ? name.substring(0, 3) : name;
    }

    String formatDate(String apiDate) {
      DateTime parseDate = DateTime.parse(apiDate);
      return DateFormat('MMMM').format(parseDate);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Hot Topics"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: hotTopic,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final movies = snapshot.data!.results;
            return ListView.builder(
              itemCount: movies.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final movie = movies[index];
                String First_air_date =
                    movie.firstAirDate?.day.toString() ?? "";
                String releaseDay = movie.releaseDate?.day.toString() ?? "";
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(movieId: movie.id)));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.releaseDate == null
                                      ? First_air_date
                                      : releaseDay,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  movie.releaseDate == null
                                      ? getShortName(
                                          formatDate(
                                              movie.firstAirDate?.toString() ??
                                                  ""),
                                        )
                                      : getShortName(
                                          formatDate(
                                              movie.releaseDate?.toString() ??
                                                  ""),
                                        ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          "$imageUrl${movie.backdropPath}"),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      "Coming ON",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      movie.releaseDate == null
                                          ? getShortName(formatDate(
                                              movie.firstAirDate?.toString() ??
                                                  ""))
                                          : getShortName(formatDate(
                                              movie.releaseDate?.toString() ??
                                                  "")),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.notification_add,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  movie.overview,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Problem fetching data"));
          }
        },
      ),
    );
  }
}
