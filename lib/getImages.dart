import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_browser/Constants.dart';

import 'getDescrip.dart';

Future<List<Movie>> fetchMovies(http.Client client) async {
  final response = await client.get(Uri.parse(Constants.api));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseMovies, response.body);
}

List<Movie> parseMovies(String responseBody) {
  final parsed =
      jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();

  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}

class Movie {
  final String posterPath;
  final int id;
  final String title;
  final String releaseDate;
  Movie({this.id, this.title, this.posterPath, this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String,
      releaseDate: json['release_date'] as String,
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
        title: Text(title),
      ),
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(20),
          color: Colors.black87,
        ),
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Movie>>(
          future: fetchMovies(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? MoviesList(movies: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class MoviesList extends StatelessWidget {
  final List<Movie> movies;

  MoviesList({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        // borderRadius: BorderRadius.circular(20),

        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DescriptionPage()))
                },
                child: Stack(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: './assets/images/placeholder.png',
                            image:
                                Constants.imagesApi + movies[index].posterPath),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text(
                          movies[index].title,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
