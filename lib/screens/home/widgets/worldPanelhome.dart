import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../countriesList.dart';

class WorldData {
  int confirmed;
  int deaths;
  int recovered;
  WorldData(this.confirmed, this.deaths, this.recovered);
}

class WorldDatapanel extends StatefulWidget {
  WorldDatapanel({Key key}) : super(key: key);

  @override
  _WorldDatapanelState createState() => _WorldDatapanelState();
}

class _WorldDatapanelState extends State<WorldDatapanel> {
  Color white = Colors.white;

  Future _worldData() async {
    var data = await http.get('https://api.covid19api.com/summary');
    //print(data);
    var jsonData = json.decode(data.body);
    var globaldata = jsonData["Global"];

    WorldData worldData = WorldData(
      globaldata["TotalConfirmed"],
      globaldata["TotalDeaths"],
      globaldata["TotalRecovered"],
    );
    return worldData;
  }

  //get numbers => _worldData();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Worldwide Statistics",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 26)),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CountriesList()));
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      padding: EdgeInsets.all(5),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Regional",
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            FutureBuilder(
              future: _worldData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  int active = (snapshot.data.confirmed) -
                      (snapshot.data.deaths + snapshot.data.recovered);
                  //print(snapshot.data);
                  return Container(
                      height: 400,
                      width: 400,
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Confirmed Cases",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              blurRadius: 15,
                                              offset: Offset(5, 5)),
                                          Shadow(
                                              blurRadius: 15,
                                              offset: Offset(5, 5)),
                                        ],
                                        color: Colors.blueGrey[200],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(snapshot.data.confirmed.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Recovered",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              blurRadius: 15,
                                              offset: Offset(5, 5)),
                                          Shadow(
                                              blurRadius: 15,
                                              offset: Offset(5, 5)),
                                        ],
                                        color: Colors.blueAccent,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(snapshot.data.recovered.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Deaths",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              blurRadius: 15,
                                              offset: Offset(5, 5)),
                                          Shadow(
                                              blurRadius: 15,
                                              offset: Offset(5, 5)),
                                        ],
                                        color: Colors.redAccent,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(snapshot.data.deaths.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Active",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              blurRadius: 15,
                                              offset: Offset(5, 5)),
                                          Shadow(
                                              blurRadius: 15,
                                              offset: Offset(5, 5)),
                                        ],
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(active.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ));
                } else {
                  return Container(
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.all(20),
                    height: 120,
                    width: 120,
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }
}
