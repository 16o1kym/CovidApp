import 'package:Covid/screens/wrapper.dart';
import 'package:Covid/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid Tracker',
        theme: ThemeData(
          primaryColor: Color(0xff1b262c),
          scaffoldBackgroundColor: Color(0xffF0F8FF),
          accentColor: Color(0xffbbe1fa),
          primarySwatch: Colors.blueGrey,
          //visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: MyHomePage(title: 'Practicing Firebase'),
        home: Wrapper(),
      ),
    );
  }
}
