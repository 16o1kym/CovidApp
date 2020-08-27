import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

var checkthis = "https://disease.sh/v3/covid-19/vaccine";

class VaccinePhaseStatusData {
  String phase;
  String candidates;
  VaccinePhaseStatusData({this.phase, this.candidates});
}

class VaccineDetails {
  String candidate;
  String details;
  String trialPhase;
  String sponsors;
  VaccineDetails(
      {this.candidate, this.details, this.trialPhase, this.sponsors});
}

class VaccineStatus extends StatefulWidget {
  VaccineStatus({Key key}) : super(key: key);

  @override
  _VaccineStatusState createState() => _VaccineStatusState();
}

class _VaccineStatusState extends State<VaccineStatus> {
  Future<List<VaccinePhaseStatusData>> vaccinePhaseStatusData() async {
    List<VaccinePhaseStatusData> listVaccinePhase = [];

    var jdata = await http.get("https://disease.sh/v3/covid-19/vaccine");
    var temp = json.decode(jdata.body);
    var phases = temp['phases'];
    for (var r in phases) {
      VaccinePhaseStatusData data = VaccinePhaseStatusData(
          phase: r['phase'], candidates: r['candidates']);
      listVaccinePhase.add(data);
    }
    return listVaccinePhase;
  }

  Future<List<VaccineDetails>> vaccineDetails() async {
    List<VaccineDetails> vaccineDetails = [];
    var jdata = await http.get("https://disease.sh/v3/covid-19/vaccine");
    var temp = json.decode(jdata.body);
    var phases = temp['data'];
    for (var r in phases) {
      VaccineDetails data = VaccineDetails(
          details: r['details'],
          trialPhase: r['trialPhase'],
          candidate: r['candidate'],
          sponsors: r['sponsors'][0]);
      vaccineDetails.add(data);
    }
    return vaccineDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Vaccine Status"),
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          children: [
            listVaccineDetails(),
            listVaccinePhaseStatus(),
          ],
        ),
      ),
    );
  }

  Widget listVaccinePhaseStatus() {
    return FutureBuilder(
        future: vaccinePhaseStatusData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(20)),
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("In phase :" + snapshot.data[index].phase),
                        Text("No. of candidates :" +
                            snapshot.data[index].candidates),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        });
  }

  Widget listVaccineDetails() {
    return FutureBuilder(
        future: vaccineDetails(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 300,
                      // maxHeight: 800,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 10, offset: Offset(4, 4))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data[index].candidate,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Developed By: " + snapshot.data[index].sponsors,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "In phase :" + snapshot.data[index].trialPhase,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data[index].details,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        });
  }
}
