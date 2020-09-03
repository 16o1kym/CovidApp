import 'package:Covid/screens/home/Formpageforpost.dart';
import 'package:Covid/screens/home/usersdataPage.dart';
import 'package:Covid/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'couponCodePage.dart';
import 'findPeople.dart';
import 'homeScreen.dart';

class Posts extends StatefulWidget {
  Posts({Key key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Important Informations"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot post = snapshot.data.docs[index];
                  return Material(
                    elevation: 14,
                    child: Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                      // margin:
                      //     EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          Text(post.data()['subject'],
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 22)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(post.data()['content'],
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Post by : " + post.data()['name'],
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18)),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(15),
                            color: Theme.of(context).primaryColor,
                            onPressed: () =>
                                launch("tel:" + post.data()['contact']),
                            child: Text("Contact : " + post.data()['contact'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Loading();
            }
          },
        ),
      ),
      bottomNavigationBar: navigationBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => FormForPost()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget navigationBar(context) {
    return CurvedNavigationBar(
      height: 50,
      animationDuration: Duration(milliseconds: 200),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: Colors.white,
      index: 0,
      buttonBackgroundColor: Colors.white,
      items: [
        Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        Icon(
          Icons.local_offer,
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
          // Navigator.push(context, MaterialPageRoute(builder: (_) => Posts()));
        } else if (index == 1) {
          //navigate to helpPage
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => CouponCodePage()));
        } else if (index == 2) {
          //navigate to home screen
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        } else if (index == 3) {
          //search courses page
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => FindPeople()));
        } else {
          //navigate to update users data page and profile
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => UserInfoPage()));
        }
      },
    );
  }
}
