import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Description extends StatelessWidget {
  final String name;
  final String image;
  final String desc;
  const Description(
      {Key? key, required this.name, required this.image, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        title: "Description".text.bold.color(context.accentColor).make(),
      ),
      body: VxBox(
              child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VxBox(
                    child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ))
                
                .color(context.cardColor)
                .width(MediaQuery.of(context).size.width)
                .height(MediaQuery.of(context).size.height * 0.4).roundedLg
                .make()
                .p12(),
            VxBox(
                      child: Column(
                children: [
                  "$name"
                      .text
                      .color(Colors.blue)
                      .bold
                      .xl2
                      .make()
                      .pOnly(top: 8,bottom: 16),
                  "$desc".text.color(context.accentColor).xl.bold.make()
                ],
              ))
                  .color(context.canvasColor)
                  .width(MediaQuery.of(context).size.width)
                  .make()
                  .p12(),
           
          ],
        ),
      ))
          .color(context.canvasColor)
          .width(MediaQuery.of(context).size.width)
          .height(MediaQuery.of(context).size.height)
          .make(),
    );
  }
}
