import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/Model/movie_recommended_model.dart';
import 'package:demo/common/utils.dart';
import 'package:flutter/material.dart';

import '../Model/movie_detail_model.dart';
import '../Services/api_services.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final ApiServices apiServices = ApiServices();
  late Future<MovieDetails?> movieDetail;
  late Future<MovieRecom?> movieRecom;

  @override
  void initState() {
    super.initState();
    fetchMovieData(); // Fetch movie data as soon as the screen is initialized
  }

  // Fetch movie details from the API
  fetchMovieData() {
    movieDetail = apiServices.movieDetail(widget.movieId);
    movieRecom = apiServices.movieRec(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String formatRuntime(int runtime) {
      int hours = runtime ~/ 60;
      int minutes = runtime % 60;
      return '${hours}h ${minutes}m';
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder<MovieDetails?>(
          future: movieDetail, // The future being passed to FutureBuilder
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Show a loading indicator while waiting
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text("Something went wrong: ${snapshot.error}"));
            }

            if (snapshot.hasData) {
              final movie = snapshot.data;
              String? genereText =
                  movie?.genres.map((genre) => genre.name).join(", ");

              return Column(
                children: [
                  Stack(
                    children: [
                      // Movie poster background
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              "https://image.tmdb.org/t/p/w500${movie?.posterPath}",
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 50,
                        child: Row(
                          children: [
                            // Close button
                            CircleAvatar(
                              backgroundColor: Colors.black38,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            // Share button (you can add functionality here)
                            CircleAvatar(
                              backgroundColor: Colors.black38,
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 100,
                        bottom: 100,
                        right: 100,
                        left: 100,
                        child: Icon(
                          Icons.play_circle_outline,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // Movie Title and other details
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              movie!.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Image.asset(
                              "asset/netflix_logo.png", // You can replace this with your actual logo path
                              height: 50,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              formatRuntime(movie.runtime),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "HD",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  // Play button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text(
                            "Play",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Download button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.download,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            "Download",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Genres and Overview Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Genres Text
                        Text(
                          genereText!,
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                        SizedBox(height: 10),

                        // Movie Overview Section
                        Text(
                          movie.overview,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis, // Handle overflow
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  // Action Buttons (My List, Like, Share)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // My List Button
                      Column(
                        children: [
                          Icon(
                            Icons.add,
                            size: 45,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "My List",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                      // Like Button
                      Column(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 45,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Like",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                      // Share Button
                      Column(
                        children: [
                          Icon(
                            Icons.share,
                            size: 45,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Share",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: movieRecom,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final movie = snapshot.data;
                          return movie!.results.isEmpty
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "More Like This",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${movie.results[index].posterPath},",
                                                height: 200,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                );
                        }
                        return SizedBox();
                      })
                ],
              );
            }

            return Center(child: Text("No data available"));
          },
        ),
      ),
    );
  }
}
