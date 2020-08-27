import 'package:Covid/screens/home/widgets/worldPanelhome.dart';
import 'package:Covid/services/auth.dart';
import 'package:flutter/material.dart';

import 'widgets/ThreeButtons.dart';
import 'widgets/continentData.dart';
import 'widgets/infoBoxHome.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(),
        ),
        appBar: AppBar(
          // leading: IconButton(
          //     icon: Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //     ),
          // onPressed: () {}),
          title: Text("Covid-19 Tracker"),
          actions: [
            FlatButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Text(
                "SignOut",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InfoBox(),
                WorldDatapanel(),
                Continentpanel(),
                Buttons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
