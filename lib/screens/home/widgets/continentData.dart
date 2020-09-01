import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Continents {
  String name;
  int population;
  int cases;
  int deaths;
  int todaycases;

  Continents(
    this.name,
    this.population,
    this.cases,
    this.deaths,
    this.todaycases,
  );
}

class Continentpanel extends StatefulWidget {
  Continentpanel({Key key}) : super(key: key);

  @override
  _ContinentpanelState createState() => _ContinentpanelState();
}

class _ContinentpanelState extends State<Continentpanel> {
  Future _continentData() async {
    var data = await http.get("https://disease.sh/v3/covid-19/continents");
    var jsondata = json.decode(data.body);
    //print(jsondata[0]);

    List<Continents> continentDataList = [];

    for (var x in jsondata) {
      Continents continent = Continents(x["continent"], x["population"],
          x["cases"], x["deaths"], x["todayCases"]);
      continentDataList.add(continent);
    }
    //print(jsondata);
    //print(continentDataList);
    return continentDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("Continent's Data",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 26)),
            ),
          ],
        ),
        Container(
          //height: MediaQuery.of(context).size.height,
          height: 730,
          child: FutureBuilder(
            future: _continentData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).primaryColor),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cases : ',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data[index].cases.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Deaths : ',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data[index].deaths.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.9)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10)
                                            ],
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Population :${snapshot.data[index].population.toString()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Cases Today :${snapshot.data[index].todaycases.toString()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }
}
