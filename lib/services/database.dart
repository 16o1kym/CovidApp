import 'package:Covid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String uid;
  Database({this.uid});

  final CollectionReference datascollection =
      FirebaseFirestore.instance.collection("users");

  Future addUserData(String name, String gender, String age, String contact,
      String city, String state) async {
    return await datascollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'age': age,
      'contact': contact,
      'city': city,
      'state': state,
    });
  }

  Stream<IndividualUserData> get usersData {
    return datascollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
  //method to get individual data

  IndividualUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return IndividualUserData(
      uid: uid,
      name: snapshot.data()['name'],
      age: snapshot.data()['age'],
      city: snapshot.data()['city'],
      contact: snapshot.data()['contact'],
      gender: snapshot.data()['gender'],
      state: snapshot.data()['state'],
    );
  }
}
