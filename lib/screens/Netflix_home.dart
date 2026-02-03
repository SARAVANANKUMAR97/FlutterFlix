import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/Model/Popular_TV_model.dart';
import 'package:demo/Model/TopRated_tv_model.dart';
import 'package:demo/Model/popular_movie_model.dart';
import 'package:demo/Model/upcoming_movies_model.dart';
import 'package:flutter/material.dart';

import '../Model/TopRated_movies_model.dart';
import '../Model/movies_model.dart';
import '../Services/api_services.dart';
import '../common/utils.dart';
import 'Search_screen.dart';
import 'movie_screen_detail.dart';

class NetflixHome extends StatefulWidget {
  const NetflixHome({super.key});

  @override
  State<NetflixHome> createState() => _NetflixHomeState();
}

class _NetflixHomeState extends State<NetflixHome> {
  final ApiServices apiServices = ApiServices();
  late Future<MovieNowplaying?> movieData;
  late Future<Upcoming?> upcoming;
  late Future<PopularMovie?> popular;
  late Future<TopRatedMovie?> topRated;
  late Future<PopularTv?> popularTv;
  late Future<TopRatedTv?> topratedTv;
  @override
  void initState() {
    movieData = apiServices.movie();
    upcoming = apiServices.upcoming();
    popular = apiServices.popular();
    topRated = apiServices.topRated();
    popularTv = apiServices.popularTv();
    topratedTv = apiServices.topRatedTv();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset(
                    "asset/netflix_logo.png",
                    height: 70,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(),
                          ));
                    },
                    icon: Icon(
                      Icons.search,
                      size: 27,
                      color: Colors.white54,
                    ),
                  ),
                  Icon(
                    Icons.download_sharp,
                    size: 27,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.cast,
                    size: 27,
                    color: Colors.white54,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.white)),
                    child: Text(
                      "Tv Shows",
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.white)),
                    child: Text(
                      "Movies",
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.white)),
                    child: Row(
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white54,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 530,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade800)),
                    child: FutureBuilder(
                      future: movieData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error:${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          final movies = snapshot.data!.results;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              itemCount: movies.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 530,
                                    width: 388,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                "$imageUrl${movie.posterPath}"))),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text("Problem to fetch data"));
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                Text(
                                  "Play",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            height: 50,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  "My Lits",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            movieTypes(
                future: upcoming,
                MovieType: "Upcoming Movies",
                isReverse: true),
            movieTypes(future: popular, MovieType: "Popular Movies"),
            movieTypes(future: popularTv, MovieType: "Popular TV Shows"),
            movieTypes(future: topRated, MovieType: "Top Rated Movies"),
            movieTypes(future: topratedTv, MovieType: "Top Rated TV Shows"),
          ],
        ),
      ),
    );
  }

  Padding movieTypes({
    required Future future,
    required String MovieType,
    bool isReverse = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MovieType,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            width: double.maxFinite,
            child: FutureBuilder(
              future: future,
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
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                          movieId: movie.id,
                                        )));
                          },
                          child: Container(
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white54,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    "$imageUrl${movie.posterPath}"),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Problem to fetch data"));
                }
              },
            ),
            height: 180,
          ),
        ],
      ),
    );
  }
}
