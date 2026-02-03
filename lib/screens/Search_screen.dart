import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/Services/api_services.dart';
import 'package:demo/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/movie_search_model.dart';
import 'movie_screen_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServices apiServices = ApiServices();
  final TextEditingController searchController = TextEditingController();

  MovieSearchBox? searchBox;
  Timer? _debounce;

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() {
          searchBox = null;
        });
        return;
      }

      final result = await apiServices.movieSearch(query);
      setState(() {
        searchBox = result;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CupertinoSearchTextField(
              controller: searchController,
              padding: const EdgeInsets.all(12),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: const Icon(Icons.cancel, color: Colors.white),
              style: const TextStyle(color: Colors.white),
              backgroundColor: Colors.grey.shade800,
              onChanged: search,
            ),
          ),

          /// RESULTS
          Expanded(
            child: searchBox == null
                ? const Center(
                    child: Text(
                      "Search for movies",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchBox!.results.length,
                    itemBuilder: (context, index) {
                      final movie = searchBox!.results[index];

                      if (movie.backdropPath == null) {
                        return const SizedBox();
                      }

                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      movieId: movie.id,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "$imageUrl${movie.backdropPath}",
                                    width: 150,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      movie.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Positioned(
                              left: 60,
                              top: 30,
                              child: Icon(
                                Icons.play_circle_outline,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
