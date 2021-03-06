import 'package:Covid/services/auth.dart';
import 'package:Covid/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "AUTHENTICATE YOURSELF",
                style: TextStyle(letterSpacing: 2),
              ),
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
                              child: Text("Login",
                                  style: TextStyle(color: Colors.white)),
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
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              "Register",
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
