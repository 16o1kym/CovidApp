import 'dart:math';

import 'package:Covid/screens/home/findPeople.dart';
import 'package:Covid/screens/home/homeScreen.dart';
import 'package:Covid/screens/home/usersdataPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:url_launcher/url_launcher.dart';

class CouponCodePage extends StatefulWidget {
  CouponCodePage({Key key}) : super(key: key);

  @override
  _CouponCodePageState createState() => _CouponCodePageState();
}

class _CouponCodePageState extends State<CouponCodePage> {
  AlertDialog couponDialog;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _initCouponDialog();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _initCouponDialog() {
    couponDialog = AlertDialog(
      title: Text("Scratch to get the coupon code!"),
      content: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 5),
        child: Scratcher(
          brushSize: 50,
          threshold: 50,
          image: Image(
            image: AssetImage('images/scratch.png'),
          ),

          // onChange: (value) => print("Scratch progress: $value%"),
          // onThreshold: () => print("Threshold reached, you won!"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Congrats! You have won a Coupon code. Use it to get upto 60% off on Udemy courses!!!",
                // style: TextStyle(
                //     color: Theme.of(context).primaryColor, fontSize: 20),
              ),
              Text(
                'COV-SOL' + '${Random.secure().nextInt(1000)}',
                // style: TextStyle(
                //     color: Theme.of(context).primaryColor, fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                // color: Theme.of(context).primaryColor,
                onPressed: () {
                  _launchURL('https://udemy.com');
                },
                child: Text(
                  "Click here to redeem it",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showCouponDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return couponDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Exciting Offers!!"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Form(
              key: _formkey,
              child: TextFormField(
                decoration:
                    InputDecoration(hintText: "I'm interested in learning..."),
                validator: (val) => val.isEmpty
                    ? "Please enter a skill you want to learn"
                    : null,
              ),
            ),
          ),
          RaisedButton(
            child: Text("Unlock new Coupon Code"),
            onPressed: () {
              if (_formkey.currentState.validate()) {
                _showCouponDialog();
              }
            },
          ),
        ],
      ),
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.only(left: 40, right: 40, bottom: 50),
      //   child: RaisedButton(
      //     child: Text("Unlock new Coupon Code"),
      //     onPressed: _showCouponDialog,
      //   ),
      // ),
      bottomNavigationBar: navigationBar(context),
    );
  }

  Widget navigationBar(context) {
    return CurvedNavigationBar(
      height: 50,
      animationDuration: Duration(milliseconds: 200),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: Colors.white,
      index: 1,
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
          // Navigator.push(context,
          //     new MaterialPageRoute(builder: (context) => CouponCodePage()));
        } else if (index == 2) {
          //navigate to home screen
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        } else if (index == 3) {
          //search courses page
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
}
