import 'package:flutter/material.dart';

import 'Constants.dart';
import 'favorites.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<List> l = getTitles();

  Future<List> m = getImages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: SingleChildScrollView(
          child: Container(
              child: Expanded(
            child: FutureBuilder(
                future: Future.wait([l, m]),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    List content = snapshot.data[0];

                    return Row(children: [
                      Expanded(
                        child: ListView.builder(
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            itemCount: content.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.network(
                                        Constants.imagesApi +
                                            snapshot.data[1][index],
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3),
                                    Text(
                                      '${snapshot.data[0][index]}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ]);
                  }
                }),
          )
              // child: ElevatedButton(
              //   child: Text('Press'),
              //   onPressed: () async {
              //     await getData();
              //   },
              // ),
              ),
        ));
  }
}
