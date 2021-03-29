import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:movies_browser/Constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_browser/authentication_service.dart';
import 'package:provider/provider.dart';
import 'getDescrip.dart';

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

Future<String> fetchTrailers(http.Client client, int id) async {
  final response = await client.get(Uri.parse(Constants.getTrailer(id)));
  print('Hellooooo ${Uri.parse(Constants.getTrailer(id))}');
  return compute(parseTrailers, response.body);
}

String parseTrailers(String responseBody) {
  final parsed =
      jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();
  print("HIII ${parsed<String>((json) => json['key'])}");
  return parsed<String>((json) => json['key']);
}

// class Trailer {
//   final String key;
//   Trailer({this.key});
//   factory Trailer.fromJson(Map<String, dynamic> json) {
//     return Trailer(
//       key: json['key'] as String,
//     );
//   }
// }

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

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            tooltip: 'Open menu',
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              tooltip: 'Open menu',
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
          centerTitle: true,
          title: Text(title),
        ),
        body: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(20),
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
                child: Container(
                  child: Image.network(
                      Constants.imagesApi + movies[itemIndex].posterPath),
                ));
          },
        ))
      ],
    );
  }
}

class PopularMoviesList extends StatelessWidget {
  final List<Movie> movies;

  PopularMoviesList({Key key, this.movies}) : super(key: key);

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
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionPage(
                                  title: movies[index].title,
                                  image: Constants.imagesApi +
                                      movies[index].posterPath,
                                  releaseD: movies[index].releaseDate,
                                  overview: movies[index].overview,
                                  ratingv: movies[index].rating)))
                    },
                    child: Flex(
                      direction: Axis.vertical,
                      // clipBehavior: Clip.antiAlias,
                      // alignment: Alignment.bottomCenter,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: './assets/images/placeholder.png',
                                image: Constants.imagesApi +
                                    movies[index].posterPath),
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
