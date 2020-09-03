import 'package:Covid/models/user.dart';
import 'package:Covid/screens/home/postStatus.dart';
import 'package:Covid/screens/home/usersdataPage.dart';
import 'package:Covid/services/database.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'couponCodePage.dart';
import 'homeScreen.dart';

class FindPeople extends StatefulWidget {
  FindPeople({Key key}) : super(key: key);

  @override
  _FindPeopleState createState() => _FindPeopleState();
}

class _FindPeopleState extends State<FindPeople> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    void _showinfopannel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ListView(
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    "Become a Hero, Become a Volunteer!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Initiative to help you connect with the people around you (within a few kms) who needs help. We use google maps services to know your location. Your can also choose to help anonymously or can disclose your identity. We would appreciate a little help in these harsh times. ",
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Need help? Ask here",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text:
                            "We know how hard this pandemic has affected people and that's why we have started this initiative. As soon you request for help, we notify the NGOs around you. If there are any volunteers registered in your area, they'll also be notified. ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                      ),
                      TextSpan(
                        text:
                            "\n\nIn an emergency, please inform us by pressing the emergency button.",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    ]),
                  )
                ],
              ),
            );
          });
    }

    return StreamBuilder<IndividualUserData>(
        stream: Database(uid: user.uid).usersData,
        builder: (context, snapshot) {
          IndividualUserData userData = snapshot.data;
          return Container(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
              ),
              body: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 14,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Lets help eachother and grow together in these uncertain times. Lets make this world a better place for everyone, again .",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor,
                        ], begin: Alignment.topLeft, end: Alignment.topRight),
                      ),
                      height: 70,
                      width: 300,
                      child: FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Thank you " +
                                      userData.name +
                                      ". We really appreciate your help. We will notify you whenever there will be someone in need around you. "),
                                );
                              });
                        },
                        child: Text(
                          "Become a Hero , Become a Volunteer!",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor
                        ], end: Alignment.topLeft, begin: Alignment.topRight),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Don't worry " +
                                      userData.name +
                                      ". We are looking for people in your locality who are willing to help and will contact you as soon as possible. Feel free to contact us in an emergency. Stay strong."),
                                  actions: [
                                    RaisedButton(
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(userData.name +
                                                  ", you will be contacted soon. Please explain your issue on the call so we can help you."),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        "Emergency",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                        onPressed: () {}, child: Container()),
                                  ],
                                );
                              });
                        },
                        child: Text(
                          "Need help? Ask here ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        width: MediaQuery.of(context).size.width - 100,
                        child: Material(
                          elevation: 4,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Know more about this inititiative ",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        _showinfopannel();
                      },
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: navigationBar(context),
            ),
          );
        });
  }
}

Widget navigationBar(context) {
  return CurvedNavigationBar(
    height: 50,
    animationDuration: Duration(milliseconds: 200),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    color: Colors.white,
    index: 3,
    buttonBackgroundColor: Colors.white,
    items: [
      Icon(
        Icons.post_add,
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => Posts()));
      } else if (index == 1) {
        //navigate to offerspage
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => CouponCodePage()));
      } else if (index == 2) {
        //navigate to home screen
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      } else if (index == 3) {
        //search people around page
        // Navigator.push(context, MaterialPageRoute(builder: (_) => FindPeople()));

      } else {
        //navigate to update users data page and profile
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => UserInfoPage()));
      }
    },
  );
}
