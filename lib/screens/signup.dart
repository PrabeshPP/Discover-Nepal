import 'package:flutter/material.dart';
import 'package:nepaltourisguide/Sub_screens/signupform.dart';
import 'package:nepaltourisguide/screens/auth.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: context.canvasColor,
            automaticallyImplyLeading: false,
          ),
        ),
        body: Stack(
          children: [
            VxBox()
                .width(MediaQuery.of(context).size.width)
                .color(context.canvasColor)
                .height(MediaQuery.of(context).size.height)
                .make(),
            Positioned(
                top: 270,
                left: 40,
                child: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpForm())),
                  child: VxBox(
                          child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        size: 30,
                        color: Colors.blue,
                      ),
                      "SignUp with Email"
                          .text
                          .bold
                          .color(Colors.blue)
                          .make()
                          .pOnly(left: 5)
                    ],
                  ))
                      .color(context.cardColor)
                      .shadowLg
                      .width(MediaQuery.of(context).size.width * 0.8)
                      .height(50)
                      .roundedLg
                      .make(),
                )),
            Positioned(
                top: 330,
                left: MediaQuery.of(context).size.width / 3.3,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Authentication()));
                    },
                    child: "Sign in with email "
                        .text
                        .xl
                        .underline
                        .color(Colors.blue)
                        .make()))
          ],
        ));
  }
}
