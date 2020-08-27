import 'package:Covid/screens/authenticate/authenticate.dart';

import 'package:Covid/screens/home/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //method to listen auth changes here because we need context!!
    final user = Provider.of<User>(context);
    //print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
