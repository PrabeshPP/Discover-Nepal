import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreen createState() => _ResetScreen();
}

class _ResetScreen extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        centerTitle: true,
        title: Text(
          "Reset Password",
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
                          borderSide:
                              BorderSide(width: 1, color: context.accentColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.blue)),
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
                10.heightBox,
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width / 3, 45)),
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Pass_reset();
                      }
                    },
                    child: Text(
                      "Send Request",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    )),
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

  void Pass_reset() {
    ;
    firebaseAuth.sendPasswordResetEmail(email: _email.text);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration:Duration(seconds: 3),
      content: Text("Password reset link has been sent to your email")));

    Navigator.pop(context);
  }
}
