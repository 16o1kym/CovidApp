import 'package:Covid/services/staticData.dart';
import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Material(
        elevation: 14,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              info,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
