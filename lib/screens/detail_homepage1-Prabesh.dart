import 'package:flutter/material.dart';
import 'package:nepaltourisguide/Sub_screens/profile.dart';
import 'package:nepaltourisguide/screens/detail_homepage.dart';
import 'package:nepaltourisguide/screens/nthg.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailHomepage1 extends StatefulWidget {
  final String desc;
  final String name;
  final Moreimg;
  final Weather1;
  final String image;
  const DetailHomepage1(
      {Key? key,
      required this.name,
      required this.Moreimg,
      required this.Weather1, required this.desc, required this.image})
      : super(key: key);

  @override
  _DetailHomepage1State createState() => _DetailHomepage1State();
}

class _DetailHomepage1State extends State<DetailHomepage1> {
  num index1 = 0;
  int pageindex = 0;
  bool? loogedIn;

  @override
  Widget build(BuildContext context) {
    List<Widget> pagelist = <Widget>[Nothing(), Profile()];

    return Scaffold(
        body: (pageindex == 0)
            ? HomedetailPage(
                name: widget.name,
                Moreimg: widget.Moreimg,
                Weather1: widget.Weather1,
                desc: widget.desc,
                image: widget.image,)
            : pagelist[pageindex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: context.canvasColor,
            unselectedItemColor: context.primaryColor,
            currentIndex: pageindex.toInt(),
            onTap: (value) {
              setState(() {
                pageindex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ]));
  }
}
