import 'package:Covid/models/user.dart';
import 'package:Covid/screens/home/couponCodePage.dart';
import 'package:Covid/services/auth.dart';
import 'package:Covid/services/database.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'findPeople.dart';
import 'homeScreen.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();

  String _currentName;
  String _gender;
  String _age;
  String _currentcontact;
  String _currentcity;
  String _currentstate;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("       Your Details"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: StreamBuilder<IndividualUserData>(
            stream: Database(uid: user.uid).usersData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                IndividualUserData userData = snapshot.data;
                return Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Text("Name"),
                      TextFormField(
                        initialValue: userData.name,
                        validator: (val) =>
                            val.isEmpty ? "Please enter your name" : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Age"),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: userData.age,
                        validator: (val) =>
                            val.isEmpty ? "Please enter your age" : null,
                        onChanged: (val) => setState(() => _age = val),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Gender"),
                      TextFormField(
                        initialValue: userData.gender,
                        validator: (val) => val.isEmpty ? "Ypur gender" : null,
                        onChanged: (val) => setState(() => _gender = val),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Contact"),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: userData.contact,
                        validator: (val) => val.isEmpty
                            ? "Please enter your contact number"
                            : null,
                        onChanged: (val) =>
                            setState(() => _currentcontact = val),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("City"),
                      TextFormField(
                        initialValue: userData.city,
                        validator: (val) =>
                            val.isEmpty ? "Please enter your city" : null,
                        onChanged: (val) => setState(() => _currentcity = val),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("State"),
                      TextFormField(
                        initialValue: userData.state,
                        validator: (val) =>
                            val.isEmpty ? "Please enter your State" : null,
                        onChanged: (val) => setState(() => _currentstate = val),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await Database(uid: user.uid).addUserData(
                                _currentName ?? userData.name,
                                _gender ?? userData.gender,
                                _age ?? userData.age,
                                _currentcontact ?? userData.contact,
                                _currentcity ?? userData.city,
                                _currentstate ?? userData.state);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          _auth.signOut();
                        },
                        child: Text(
                          "SignOut",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
      bottomNavigationBar: navigationBar(context),
    );
  }

  Widget navigationBar(context) {
    return CurvedNavigationBar(
      height: 50,
      animationDuration: Duration(milliseconds: 200),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: Colors.white,
      index: 4,
      buttonBackgroundColor: Colors.white,
      items: [
        Icon(
          Icons.fastfood,
          color: Theme.of(context).primaryColor,
        ),
        Icon(
          Icons.local_offer_rounded,
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
          //navigate to restaurant nearby list
        } else if (index == 1) {
          //navigate to helpPage
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CouponCodePage()));
        } else if (index == 2) {
          //navigate to home screen
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        } else if (index == 3) {
          //search courses page
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => FindPeople()));
        } else {
          //navigate to update users data page and profile
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => UserInfoPage()));
        }
      },
    );
  }
}
