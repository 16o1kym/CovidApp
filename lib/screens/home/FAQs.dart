import 'package:Covid/shared/staticData.dart';
import 'package:flutter/material.dart';

class FaqsPage extends StatefulWidget {
  FaqsPage({Key key}) : super(key: key);

  @override
  _FaqsPageState createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text(("Frequently Asked Questions"))),
        body: Container(
          child: ListView.builder(
              //itemCount: questionAnswers.length,
              itemCount: questionAnswers.length,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  child: ExpansionTile(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Text(
                      questionAnswers[i]['question'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Material(
                        elevation: 40,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              questionAnswers[i]['answer'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
