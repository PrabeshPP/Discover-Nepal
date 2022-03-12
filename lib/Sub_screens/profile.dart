import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepaltourisguide/screens/signup.dart';
import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  final uid;

  const Profile({Key? key, this.uid}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool? loggedIn;
  var name;
  var email;
  var name1;

  User? user = FirebaseAuth.instance.currentUser;
  final databaseRef = FirebaseDatabase(
          databaseURL:
              "https://authapp-d2856-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .reference()
      .child("User");

  @override
  Widget build(BuildContext context) {
    (user != null)
        ? databaseRef.child("${user!.uid}").once().then((DataSnapshot data) {
            if (mounted)
              setState(() {
                name = data.value;
                name1 = name["name"];
                email = name["email"];
              });
          })
        : 1 + 1;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: context.canvasColor,
            automaticallyImplyLeading: false,
          ),
        ),
        body: (user != null)
            ? (name1 != null && email != null)
                ? Body(
                    name: name1,
                    email: email,
                  )
                : Center(child: CircularProgressIndicator())
            : SignUp());
  }
}

class Body extends StatefulWidget {
  final String name;
  final String email;

  const Body({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final databaseRef1 = FirebaseDatabase(
          databaseURL:
              "https://authapp-d2856-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .reference()
      .child("Suggested places name");
  final databaseRef2 = FirebaseDatabase(
          databaseURL:
              "https://authapp-d2856-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .reference()
      .child("Feedback");
  TextEditingController Placename = TextEditingController();
  TextEditingController feedback = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                 
                  padding: EdgeInsets.zero,
                  child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.transparent),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.grey,
                      maxRadius: 200,
                      minRadius: 10,
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    accountName:
                        "${widget.name}".text.color(context.accentColor).make(),
                    accountEmail: "${widget.email}"
                        .text
                        .color(context.accentColor)
                        .make(),
                  )),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 20.0,
                          title: Text("Suggest Someplace"),
                          content: Form(
                            key: _formkey,
                            child: TextFormField(
                              autofocus: true,
                              maxLength: 100,
                              controller: Placename,
                              decoration: InputDecoration(
                                  hintText: "suggest a place near to you",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.red,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Place name cannot be empty!";
                                } else if (value.trim().isEmpty) {
                                  return "Place name cannot be space!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all(Size(50, 40)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0))),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Placename.clear();
                                  setState(() {});
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                )),
                            ElevatedButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all(Size(50, 40)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0))),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    add_to_fbdb();
                                    Placename.clear();
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        );
                      });
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: context.accentColor))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.blue,
                            ).pOnly(left: 16),
                            "Suggest some place"
                                .text
                                .color(context.accentColor)
                                .xl
                                .make()
                                .pOnly(left: 16, top: 4)
                          ],
                        ),
                      ],
                    )).p12(),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("What should we add next?"),
                          content: Form(
                              key: _formkey,
                              child: TextFormField(
                                maxLines: 5,
                                controller: feedback,
                                decoration: InputDecoration(
                                    hintText: "feedback",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.red))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Feedback cannot be empty!";
                                  } else if (value.trim().isEmpty) {
                                    return "Feedback can not be space!";
                                  } else {
                                    return null;
                                  }
                                },
                              )),
                          actions: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all(Size(50, 40)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0))),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  feedback.clear();
                                  setState(() {});
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                )),
                            ElevatedButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all(Size(50, 40)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0))),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    feedback_to_firebase();
                                  }
                                  feedback.clear();

                                  setState(() {});
                                },
                                child: Text(
                                  "Sumbmit",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        );
                      });
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: context.accentColor))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.feedback,
                              size: 30,
                              color: Colors.blue,
                            ).pOnly(left: 16),
                            "Feedback"
                                .text
                                .color(context.accentColor)
                                .xl
                                .make()
                                .pOnly(left: 16, top: 4)
                          ],
                        ),
                      ],
                    )).p12(),
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((value) => Navigator.pop(context));
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: context.accentColor))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              size: 25,
                              color: Colors.blue,
                            ).pOnly(left: 16),
                            "Logout"
                                .text
                                .color(context.accentColor)
                                .xl
                                .make()
                                .pOnly(left: 16, top: 4)
                          ],
                        ),
                      ],
                    )).p12(),
              ),
            ],
          ),
        )
        );
  }

  //adding suggested place to the firebase database
  void add_to_fbdb() {
    Random random = Random();
    int randnum = random.nextInt(200);
    databaseRef1
        .child("Suggest some place${randnum} by ${widget.name}")
        .set({"Suggested place": Placename.text}).then((value) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          content:
              "We will add this place soon!".text.color(Colors.white).make()));
    });
  }

  void feedback_to_firebase() {
    databaseRef2.child("Feedabck by ${widget.name}").set(
        {"Feedback": feedback.text}).then((value) => Navigator.pop(context));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        content:
            "Thank you for the feedback!".text.color(Colors.white).make()));
  }

  @override
  void dispose() {
    super.dispose();
    Placename.dispose();
    feedback.dispose();
  }
}
