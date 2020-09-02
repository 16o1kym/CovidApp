import 'package:Covid/screens/home/couponCodePage.dart';
import 'package:Covid/screens/home/findPeople.dart';
import 'package:Covid/screens/home/usersdataPage.dart';
import 'package:Covid/screens/home/widgets/worldPanelhome.dart';
import 'package:Covid/services/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Covid-19 Tracker"),
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
        Icons.fastfood,
        color: Theme.of(context).primaryColor,
      ),
      Icon(
        Icons.local_offer_sharp,
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
        //navigate to restaurant nearby list
      } else if (index == 1) {
        //navigate to offerspage
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => CouponCodePage()));
      } else if (index == 2) {
        //navigate to home screen
        //Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      } else if (index == 3) {
        //search people around page
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => FindPeople()));
      } else {
        //navigate to update users data page and profile
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => UserInfoPage()));
      }
    },
  );
}
