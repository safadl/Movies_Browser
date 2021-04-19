import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Future<void> DeleteMovie(String id) async {}
Future<List> getData() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('favorites').get();

  // Get data from docs and convert map to List
  final allData =
      querySnapshot.docs.map((doc) => doc.data()['title']).toSet().toList();

  print(allData);
  return allData;
}

Future<void> AddFavorite(String title, String image) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');
  favorites.add({'title': title, 'uid': uid, 'image': image});
  print('favorite added');
  return;
}
