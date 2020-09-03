import 'package:Covid/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormForPost extends StatefulWidget {
  FormForPost({Key key}) : super(key: key);

  @override
  _FormForPostState createState() => _FormForPostState();
}

class _FormForPostState extends State<FormForPost> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _subject;
  String _content;
  String _contact;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Material(
            elevation: 14,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Post about anything you feel can help people around you. Please restrict yourself from posting messages asking for help here. Post will be deleted after 24 hours. ",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            height: 500,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? "Please enter your name" : null,
                    decoration: InputDecoration(labelText: "Name"),
                    onChanged: (value) => setState(() => _name = value),
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? "Please enter the subject" : null,
                    decoration: InputDecoration(labelText: "Subject"),
                    onChanged: (value) => setState(() => _subject = value),
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? "Please enter the content" : null,
                    decoration: InputDecoration(labelText: "Content"),
                    onChanged: (value) => setState(() => _content = value),
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty
                        ? "Please enter your contact information"
                        : null,
                    decoration: InputDecoration(labelText: "Contact"),
                    onChanged: (value) => setState(() => _contact = value),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Post",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await Database()
                            .addPost(_name, _subject, _content, _contact);
                        Navigator.pop(context);

                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Post added successfully"),
                              );
                            });
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
