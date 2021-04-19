import 'package:flutter/material.dart';

import 'favorites.dart';

class FavoriteScreen extends StatelessWidget {
  Future<List> l = getData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
            child: SingleChildScrollView(
          child: Expanded(
            child: FutureBuilder(
                future: l,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else
                    return Row(children: [
                      Expanded(
                        child: ListView.builder(
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Text(
                                    '${snapshot.data[index]}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              );
                            }),
                      )
                    ]);
                }),
          ),
        )
            // child: ElevatedButton(
            //   child: Text('Press'),
            //   onPressed: () async {
            //     await getData();
            //   },
            // ),
            ));
  }
}
