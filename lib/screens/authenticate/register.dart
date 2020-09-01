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
        : Container(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Sign-Up Page"),
                actions: [
                  FlatButton(
                    child: Text(
                      "Sign-In",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    },
                  )
                ],
              ),
              body: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
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
                                    color: Theme.of(context).primaryColor)),
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
                            child: Text("Sign up"),
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
                        Text(error),
                      ],
                    ),
                  )),
            ),
          );
  }
}
