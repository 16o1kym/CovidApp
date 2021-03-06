import 'package:Covid/screens/authenticate/sign_in.dart';
import 'package:Covid/screens/home/couponCodePage.dart';
import 'package:Covid/screens/home/findPeople.dart';
import 'package:Covid/screens/home/postStatus.dart';
import 'package:Covid/screens/home/usersdataPage.dart';
import 'package:Covid/screens/home/widgets/worldPanelhome.dart';
import 'package:Covid/services/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Covid-19 Tracker"),
        actions: [
          FlatButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 6, right: 6, bottom: 10),
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
      bottomNavigationBar: navigationBar(context),
    );
  }
}

Widget navigationBar(context) {
  return CurvedNavigationBar(
    height: 50,
    animationDuration: Duration(milliseconds: 200),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    color: Colors.white,
    index: 2,
    buttonBackgroundColor: Colors.white,
    items: [
      Icon(
        Icons.add,
        color: Theme.of(context).primaryColor,
      ),
      Icon(
        Icons.local_offer,
        color: Theme.of(context).primaryColor,
      ),
      Icon(
        Icons.home,
        color: Theme.of(context).primaryColor,
      ),
      Icon(
        Icons.search,
        color: Theme.of(context).primaryColor,
      ),
      Icon(
        Icons.person,
        color: Theme.of(context).primaryColor,
      ),
    ],
    onTap: (index) {
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Posts()));
      } else if (index == 1) {
        //navigate to offerspage
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => CouponCodePage()));
      } else if (index == 2) {
        //navigate to home screen
        //Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      } else if (index == 3) {
        //search people around page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => FindPeople()));
      } else {
        //navigate to update users data page and profile
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => UserInfoPage()));
      }
    },
  );
}
