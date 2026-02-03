// To parse this JSON data, do
//
//     final movieRecom = movieRecomFromJson(jsonString);

import 'dart:convert';

MovieRecom movieRecomFromJson(String str) =>
    MovieRecom.fromJson(json.decode(str));

String movieRecomToJson(MovieRecom data) => json.encode(data.toJson());

class MovieRecom {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  MovieRecom({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieRecom.fromJson(Map<String, dynamic> json) => MovieRecom(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  bool adult;
  String backdropPath;
  int id;
  String name;
  String originalName;
  String overview;
  String posterPath;
  MediaType mediaType;
  OriginalLanguage originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime firstAirDate;
  double voteAverage;
  int voteCount;
  List<OriginCountry> originCountry;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        originalLanguage:
            originalLanguageValues.map[json["original_language"]]!,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        originCountry: List<OriginCountry>.from(
            json["origin_country"].map((x) => originCountryValues.map[x]!)),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": List<dynamic>.from(
            originCountry.map((x) => originCountryValues.reverse[x])),
      };
}

enum MediaType { TV }

final mediaTypeValues = EnumValues({"tv": MediaType.TV});

enum OriginCountry { CA, GB, US }

final originCountryValues = EnumValues(
    {"CA": OriginCountry.CA, "GB": OriginCountry.GB, "US": OriginCountry.US});

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
