import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Hotel extends StatelessWidget {
  const Hotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Hotel".text.xl2.color(context.accentColor).make(),
        backgroundColor: context.canvasColor,
      ),
      body: Stack(
        children: [
          VxBox(
                  child: Image.network(
            "https://cdn.pixabay.com/photo/2017/07/28/23/18/coming-soon-2550190_960_720.jpg",
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes!=null
                  ?loadingProgress.cumulativeBytesLoaded
                  /loadingProgress.expectedTotalBytes!:null,
                ),
              );
            },
          ))
              .width(MediaQuery.of(context).size.width)
              .height(MediaQuery.of(context).size.height)
              .make(),
        ],
      ),
    );
  }
}
