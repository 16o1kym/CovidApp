import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Countriesdata {
  String countryName;
  String countryCode;
  int cases;
  int deaths;
  int recovered;
  String date;
  Countriesdata(this.countryName, this.countryCode, this.cases, this.deaths,
      this.recovered);
}

class CountriesList extends StatefulWidget {
  CountriesList({Key key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  Color white = Colors.white;
  Future _countriesData() async {
    List<Countriesdata> countriesData = [];
    var data = await http.get('https://api.covid19api.com/summary');
    //print(data);
    var jsonData = json.decode(data.body);
    //print(jsonData["Countries"]);
    var finaljsondata = jsonData["Countries"];
    for (var y in finaljsondata) {
      Countriesdata country = Countriesdata(y["Country"], y["CountryCode"],
          y["TotalConfirmed"], y["TotalDeaths"], y["TotalRecovered"]);
      countriesData.add(country);
    }
    return countriesData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Countries List"),
        ),
        body: Container(
          child: FutureBuilder(
            future: _countriesData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20)),
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 60,
                              width: 60,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  snapshot.data[index].countryCode,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: (snapshot.data[index].countryName.length <=
                                      14)
                                  ? Text(snapshot.data[index].countryName,
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                blurRadius: 0.5,
                                                offset: Offset(0.25, 0.25))
                                          ],
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                  : Text(
                                      snapshot.data[index].countryName
                                              .substring(0, 14) +
                                          '...',
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                blurRadius: 0.5,
                                                offset: Offset(0.25, 0.25))
                                          ],
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                      "Cases : ${snapshot.data[index].cases.toString()}",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                      "Recovered : ${snapshot.data[index].recovered.toString()}",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                      "Deaths : ${snapshot.data[index].deaths.toString()}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Fetching data...",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          // shadows: [
                          //   Shadow(
                          //       color: Colors.black,
                          //       blurRadius: 20,
                          //       offset: Offset(5, 10))
                          // ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
