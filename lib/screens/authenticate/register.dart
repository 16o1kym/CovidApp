// import 'dart:wasm';

import 'package:Covid/services/auth.dart';
import 'package:Covid/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //set the property with name toggleView
  final Function toggleView;
  //Register({Key key}) : super(key: key);
  //add the constructor for the property
  Register({this.toggleView()});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "REGISTER",
                style: TextStyle(letterSpacing: 2),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 5,
                            offset: Offset(2, 3))
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 400,
                    width: 350,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor)),
                            ),
                            validator: (value) => value.isEmpty
                                ? "Please enter a valid email"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor)),
                            ),
                            validator: (value) => value.length < 6
                                ? "Password must be atleast 6 characters long"
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Get Started",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  print(email);
                                  print(password);
                                  dynamic result =
                                      await _auth.signUpUsingEmailAndPassword(
                                          email, password);
                                  setState(() {
                                    loading = true;
                                  });
                                  if (result == null) {
                                    setState(() {
                                      error = "Enter a valid email";
                                      loading = false;
                                    });
                                  }
                                }
                              }),
                          SizedBox(
                            height: 40,
                          ),
                          RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              "Already have a account? Sign-In here!",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              widget.toggleView();
                            },
                          ),
                          Text(error),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/logo.png'))),
                  ),
                ],
              ),
            ),
          );
  }
}
