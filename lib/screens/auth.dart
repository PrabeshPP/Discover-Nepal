import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepaltourisguide/screens/homepage.dart';
import 'package:nepaltourisguide/screens/resetscreen.dart';
import 'package:nepaltourisguide/screens/signup.dart';
import 'package:nepaltourisguide/utils/loading.dart';
import 'package:velocity_x/velocity_x.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool tapped = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: context.canvasColor,
              centerTitle: true,
              title: Text(
                "Login",
                style: TextStyle(
                    color: context.accentColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: VxBox(
                      child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: context.accentColor),
                        cursorColor: context.accentColor,
                        controller: _email,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: context.accentColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue)),
                            hintText: "enter email",
                            labelText: "Email",
                            labelStyle: TextStyle(color: context.accentColor),
                            hintStyle: TextStyle(color: context.accentColor)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email field cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ).pOnly(left: 32, right: 32, top: 150, bottom: 12),
                      TextFormField(
                        style: TextStyle(color: context.accentColor),
                        cursorColor: context.accentColor,
                        controller: _password,
                        obscureText: tapped ? false : true,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  tapped = tapped.toggle();
                                  setState(() {});
                                },
                                child: tapped
                                    ? Icon(CupertinoIcons.eye_slash_fill)
                                    : Icon(CupertinoIcons.eye_solid)),
                            fillColor: context.accentColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: context.accentColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue)),
                            hintText: "enter password",
                            labelText: "Password",
                            labelStyle: TextStyle(color: context.accentColor),
                            hintStyle: TextStyle(color: context.accentColor)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password can not be empty";
                          } else {
                            return null;
                          }
                        },
                      ).pOnly(left: 32, right: 32),
                      10.heightBox,
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                              minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width / 3, 45)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              logintoFB();
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                          )),
                      Material(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Don't have an account?"
                                  .text
                                  .color(context.accentColor)
                                  .make(),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: "Register"
                                      .text
                                      .color(Colors.blue)
                                      .xl
                                      .make())
                            ]),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetScreen()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
              ))
                  .width(MediaQuery.of(context).size.width)
                  .height(MediaQuery.of(context).size.height)
                  .make(),
            ),
          );
  }

  void logintoFB() {
    setState(() => loading = true);
    firebaseAuth
        .signInWithEmailAndPassword(
            email: _email.text, password: _password.text)
        .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(
            seconds: 2
          ),backgroundColor: Colors.red
          ,content:"Welcome to Discover Nepal family!".text.xl.bold.color(Colors.white).make()));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    }).catchError((err) {
      setState(() => loading = false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}
