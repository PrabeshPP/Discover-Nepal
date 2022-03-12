import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PlaceDesc extends StatelessWidget {
  final String name;
  final String desc;
  final String image;
  const PlaceDesc(
      {Key? key, required this.name, required this.desc, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        title: "About the place".text.xl.bold.color(context.accentColor).make(),
      ),
      body: VxBox(
              child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: VxBox(
                      child: Image.network(
                image,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes!=null?
                      loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes!:null,
                    ),
                  );
                },
              ))
                  .color(context.cardColor)
                  
                  .width(MediaQuery.of(context).size.width * 0.95)
                  .height(MediaQuery.of(context).size.height * 0.4)
                  .make(),
            ),
            VxBox(
                    child: Column(
              children: [
                "${name}".text.bold.xl2.color(context.accentColor).make().pOnly(top: 8),
                "${desc}".text.xl.bold.color(context.accentColor).make().pOnly(top: 12)
              ],
            ))
                .width(MediaQuery.of(context).size.width * 0.95)
                
                .make()
          ],
        ),
      ))
          .width(MediaQuery.of(context).size.width)
          .color(context.canvasColor)
          .height(MediaQuery.of(context).size.height)
          .make(),
    );
  }
}
