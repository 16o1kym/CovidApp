import 'package:Covid/screens/home/vaccinestatus.dart';
import 'package:flutter/material.dart';

import '../FAQs.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key key}) : super(key: key);

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
          GestureDetector(child: button(context, "Donate")),
          GestureDetector(child: button(context, "Myth Buster")),
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
