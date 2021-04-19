import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

final _url = 'https://www.youtube.com/results?search_query=';

void _launchURL(int id, key) async {
  await canLaunch(_url + mtitle + " trailer")
      ? await launch(_url + mtitle + " trailer")
      : throw 'Could not launch ${_url + mtitle + " trailer"}';
}

var mtitle;

class DescriptionPage extends StatelessWidget {
  final String title;
  final String image;
  final String releaseD;
  final String overview;
  final num ratingv;
  final int id;
  final String keyy;
  DescriptionPage(
      {this.id,
      this.title,
      this.image,
      this.releaseD,
      this.overview,
      this.ratingv,
      this.keyy});
  @override
  Widget build(BuildContext context) {
    mtitle = this.title;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      appBar: AppBar(
        title: Text("Movie Description "),
        centerTitle: true,
      ),
      body: ClipRRect(
        child: Stack(
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            BackdropFilter(
              child: Container(
                color: Colors.black12,
              ),
              filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 150),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.yellow[900],
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 280),
                  child: Text(
                    releaseD,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 280),
                  child: RatingBarIndicator(
                    rating: ratingv.toDouble() / 2,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 500),
              child: Text(
                overview,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: 1.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  tooltip: 'Play Trailer',
                  onPressed: () => {_launchURL(id, key)},
                  child: const Icon(Icons.play_arrow, color: Colors.white),
                  backgroundColor: Colors.redAccent[700],
                ),
              ),
            ),
          ],
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
