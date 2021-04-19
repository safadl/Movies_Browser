import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:movies_browser/Constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_browser/authentication_service.dart';
import 'package:movies_browser/favorites.dart';
import 'package:provider/provider.dart';
import 'getDescrip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Movie>> fetchPopularMovies(http.Client client) async {
  final response = await client.get(Uri.parse(Constants.PopularApi));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePopularMovies, response.body);
}

List<Movie> parsePopularMovies(String responseBody) {
  final parsed =
      jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();

  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}

Future<List<Movie>> fetchTrendingMovies(http.Client client) async {
  final response = await client.get(Uri.parse(Constants.TrendingApi));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseTrendingMovies, response.body);
}

List<Movie> parseTrendingMovies(String responseBody) {
  final parsed =
      jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();

  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}

class Movie {
  final String posterPath;
  final int id;
  final String title;
  final String releaseDate;
  final String overview;
  final num rating;
  Movie(
      {this.id,
      this.title,
      this.posterPath,
      this.releaseDate,
      this.overview,
      this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String,
      releaseDate: json['release_date'] as String,
      overview: json['overview'] as String,
      rating: json['vote_average'] as num,
    );
  }
}

class MoviesScreen extends StatelessWidget {
  final String title;

  MoviesScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            padding: const EdgeInsets.all(8.0),
            // height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),

                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<Movie>>(
                        future: fetchTrendingMovies(http.Client()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? TrendingMovies(movies: snapshot.data)
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<Movie>>(
                        future: fetchPopularMovies(http.Client()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? PopularMoviesList(movies: snapshot.data)
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

class TrendingMovies extends StatelessWidget {
  final List<Movie> movies;

  TrendingMovies({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 20, top: 10),
            child: Text('Trending',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700)),
          ),
          Icon(Icons.trending_up, color: Colors.white)
        ]),
        Container(
            child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 300.0,
            viewportFraction: 0.6,
            enlargeCenterPage: true,
          ),
          itemCount: movies.length,
          itemBuilder: (context, itemIndex, index) {
            return GestureDetector(
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionPage(
                                    id: movies[itemIndex].id,
                                    title: movies[itemIndex].title,
                                    image: Constants.imagesApi +
                                        movies[itemIndex].posterPath,
                                    releaseD: movies[itemIndex].releaseDate,
                                    overview: movies[itemIndex].overview,
                                    ratingv: movies[itemIndex].rating,
                                  ))),
                    },
                child: Stack(children: [
                  Container(
                    child: Image.network(
                        Constants.imagesApi + movies[itemIndex].posterPath),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.bookmark,
                        color: Colors.white,
                      ))
                ]));
          },
        ))
      ],
    );
  }
}

class PopularMoviesList extends StatefulWidget {
  final List<Movie> movies;
  PopularMoviesList({Key key, this.movies}) : super(key: key);
  @override
  _PopularMoviesListState createState() => _PopularMoviesListState();
}

class _PopularMoviesListState extends State<PopularMoviesList> {
  bool check = false;
  List<bool> _isFavorite = List.filled(200, false);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 8.0),
              child: Text('Popular',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700)),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: widget.movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionPage(
                                  title: widget.movies[index].title,
                                  image: Constants.imagesApi +
                                      widget.movies[index].posterPath,
                                  releaseD: widget.movies[index].releaseDate,
                                  overview: widget.movies[index].overview,
                                  ratingv: widget.movies[index].rating)))
                    },
                    child: Flex(
                      direction: Axis.vertical,
                      // clipBehavior: Clip.antiAlias,
                      // alignment: Alignment.bottomCenter,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Stack(
                              children: [
                                Container(
                                  child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      placeholder:
                                          './assets/images/placeholder.png',
                                      image: Constants.imagesApi +
                                          widget.movies[index].posterPath),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      onPressed: () => {
                                        setState(() => _isFavorite[index] =
                                            !_isFavorite[index]),
                                        print("FAVORITE MOVIE IS " +
                                            widget.movies[index].title),
                                        if (_isFavorite[index] == true)
                                          {
                                            AddFavorite(
                                                widget.movies[index].title,
                                                widget.movies[index].posterPath)
                                          }
                                      },
                                      icon: Icon(
                                          _isFavorite[index] == false
                                              ? Icons.bookmark_border
                                              : Icons.bookmark,
                                          color: Colors.white),
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ]),
    );
  }
}
