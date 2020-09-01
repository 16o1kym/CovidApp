import 'dart:math';

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
  @override
  void initState() {
    // TODO: implement initState
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
      title: Text("Sample Alert Dialog"),
      content: Scratcher(
        brushSize: 50,
        threshold: 50,
        image: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRk7Uai4S_2J2Xn8sT_MX0BUpYNhrGDBZ9Swg&usqp=CAU'),
        color: Colors.red,
        onChange: (value) => print("Scratch progress: $value%"),
        onThreshold: () => print("Threshold reached, you won!"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Congrats! You have won a Coupon code"),
            Text('${Random.secure().nextInt(1000)}'),
            RaisedButton(
              onPressed: () {
                _launchURL('https://udemy.com');
              },
              child: Text("Click here to redeem it"),
            )
          ],
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
        title: Text("Unlock Coupon Codes"),
      ),
      body: Container(),
      bottomSheet: FlatButton(
        child: Text("Unlock new Coupon Code"),
        onPressed: _showCouponDialog,
      ),
    );
  }
}
