import 'package:Covid/services/auth.dart';
import 'package:Covid/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //set the property with name toggleView
  final Function toggleView;
  //SignIn({Key key}) : super(key: key);
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email;
  String password;
  String error = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Sign-In"),
                actions: [
                  FlatButton(
                    child: Text(
                      "Register",
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
                            child: Text("Sign in"),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInUsingEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        "Could not sign in with those credentials.\n \t \t \t \t \t  Please register first.";
                                  });
                                }
                              }
                            }),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                            child: Text("Sign-in anonymously"),
                            onPressed: () async {
                              //User result = await _auth.signInAnon();
                              //the above line will also work fine.

                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                print("error signing in");
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                print("signed in succesfully");
                                print(result.uid);
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
