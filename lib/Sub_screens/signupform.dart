import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepaltourisguide/screens/homepage.dart';
import 'package:nepaltourisguide/utils/loading.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();
  bool onTap = false;
  bool onTapre = false;
  bool loading = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databaseref = FirebaseDatabase(
          databaseURL:
              "https://authapp-d2856-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .reference()
      .child("User");

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  String? pass;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Form(
                key: _formkey,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    "Sign up"
                        .text
                        .color(context.accentColor)
                        .xl2
                        .make()
                        .pOnly(top: 50),
                    TextFormField(
                      controller: emailController,
                      cursorColor: context.accentColor,
                      style: TextStyle(color: context.accentColor),
                      decoration: InputDecoration(
                        hintText: "enter your email",
                        hintStyle: TextStyle(color: context.accentColor),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: context.accentColor),
                            borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide: BorderSide(
                                width: 1, color: context.accentColor)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email can not be empty !";
                        } else if (value.trim().isEmpty) {
                          return "email can not be space!";
                        } else {
                          return null;
                        }
                      },
                    ).pOnly(left: 32, right: 32, top: 12, bottom: 12),
                    TextFormField(
                      obscureText: onTap ? false : true,
                      controller: passwordController,
                      style: TextStyle(color: context.accentColor),
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                onTap = onTap.toggle();
                                setState(() {});
                              },
                              child: onTap
                                  ? Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Colors.deepOrange,
                                    )
                                  : Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Colors.grey,
                                    )),
                          hintText: "enter your password",
                          hintStyle: TextStyle(color: context.accentColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor),
                              borderRadius: BorderRadius.circular(32.0))),
                      validator: (value) {
                        pass = value!;
                        setState(() {});
                        if (value.isEmpty) {
                          return "Password can not be empty";
                        } else if (value.trim().isEmpty) {
                          return "Password can not be space!";
                        } else {
                          return null;
                        }
                      },
                    ).pOnly(left: 32, right: 32, bottom: 12),
                    TextFormField(
                      style: TextStyle(color: context.accentColor),
                      obscureText: onTapre ? false : true,
                      controller: rePasswordController,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              onTapre = onTapre.toggle();
                              setState(() {});
                            },
                            child: onTapre
                                ? Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    color: Colors.deepOrange,
                                  )
                                : Icon(
                                    CupertinoIcons.eye_fill,
                                    color: Colors.grey,
                                  ),
                          ),
                          hintText: "re-enter your password",
                          hintStyle: TextStyle(color: context.accentColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor),
                              borderRadius: BorderRadius.circular(32.0))),
                      validator: (value) {
                        if (value != pass) {
                          return "Password must be same";
                        } else if (value!.isEmpty) {
                          return "password can not be empty";
                        } else if (value.trim().isEmpty) {
                          return "Password can not be space!";
                        } else
                          return null;
                      },
                    ).pOnly(left: 32, right: 32, bottom: 12),
                    TextFormField(
                      style: TextStyle(color: context.accentColor),
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "enter your name",
                          hintStyle: TextStyle(color: context.accentColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: context.accentColor, width: 1))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name can not be empty";
                        } else if (value.trim().isEmpty) {
                          return "Name can not be space!";
                        } else {
                          return null;
                        }
                      },
                    ).pOnly(left: 32, right: 32, bottom: 12),
                    TextFormField(
                      style: TextStyle(color: context.accentColor),
                      controller: ageController,
                      keyboardType:TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "enter your age",
                          hintStyle: TextStyle(color: context.accentColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Age can not be empty";
                        } else if (value.trim().isEmpty) {
                          return "age can not be space!";
                        } else if (int.parse(value) >= 100) {
                          return "age can not be more than 100!";
                        } else {
                          return null;
                        }
                      },
                    ).pOnly(left: 32, right: 32, bottom: 12),
                    ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(150, 45)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)))),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          registerToFb();
                        }
                      },
                      child: "Submit".text.make(),
                    )
                  ],
                ))),
          );
  }

  void registerToFb() async {
    setState(() => loading = true);
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      databaseref.child(result.user!.uid).set({
        "email": emailController.text,
        "age": ageController.text,
        "name": nameController.text
      }).then((res) {
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      });
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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    ageController.dispose();
  }
}
