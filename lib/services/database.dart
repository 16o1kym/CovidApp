import 'package:Covid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String uid;
  Database({this.uid});

  final CollectionReference datascollection =
      FirebaseFirestore.instance.collection("users");

  Future addUserData(String name, String sugar, int strength) async {
    return await datascollection.doc(uid).set({
      'name': name,
      'sugar': sugar,
      'strength': strength,
    });
  }

//video 19 => if there's doubt .. watch video 18 and 19 :)

  List<UserData> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          //if it will be a empty string .. give empty string => ??
          // name: doc.data['name'] ?? '',
          // sugar: doc.data['sugar'] ?? '0',
          // strength: doc.data['strength'] ?? 0,
          );
    }).toList();
  }

//get brwews stream
  // Stream<QuerySnapshot> get brews {
  //   return datascollection.snapshots();
  // }

  Stream<List<UserData>> get brews {
    return datascollection.snapshots().map((_brewListFromSnapshot));
  }
}
