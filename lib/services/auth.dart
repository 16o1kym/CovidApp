import 'package:Covid/models/user.dart';
import 'package:Covid/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser

  // _userFromFirebaseUser is a method of class User

  UserData _userFromFirebase(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  //listen to auth change using stream
  //stream will return user when signed in and null when signed out.
  Stream<User> get user {
    return _auth.authStateChanges();
    // dynamic result = _auth.authStateChanges();
    // return _userFromFirebase(result);
    // .map((User user) => _userFromFirebase(user));
    //can also write as:
    // .map(_userFromFirebase);
    //it will automatically pass firebase user to _userFromFirebase.
  }

  //sign in annonymously

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signIn with email and password

  Future signInUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //signUp with email and password

  Future signUpUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await Database(uid: user.uid)
          .addUserData("New member", "", 0, "", "", "");

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
