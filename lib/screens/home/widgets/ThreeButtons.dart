import 'package:Covid/screens/home/vaccinestatus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../FAQs.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key key}) : super(key: key);
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FaqsPage()));
              },
              child: button(context, "FAQ(s)")),
          GestureDetector(
            child: button(context, "Donate"),
            onTap: () {
              _launchURL('https://covid19responsefund.org/en/');
            },
          ),
          GestureDetector(
            child: button(context, "Myth Buster"),
            onTap: () {
              _launchURL(
                  'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
            },
          ),
          GestureDetector(
            child: button(context, "Vaccine Status"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => VaccineStatus()));
            },
          ),
        ],
      ),
    );
  }
}

Widget button(BuildContext context, String buttonName) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20)),
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          buttonName,
          style: TextStyle(color: Colors.white, letterSpacing: 2),
        ),
        Icon(
          Icons.arrow_right,
          color: Colors.white,
        )
      ],
    ),
  );
}
