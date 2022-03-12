import 'package:flutter/material.dart';
import 'package:nepaltourisguide/Sub_screens/emergency.dart';
import 'package:nepaltourisguide/Sub_screens/festival.dart';
import 'package:nepaltourisguide/Sub_screens/food.dart';
import 'package:velocity_x/velocity_x.dart';

class TravelDesk extends StatelessWidget {
  const TravelDesk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.canvasColor,
        title: "Travel Desk".text.xl2.color(context.accentColor).bold.make(),
      ),
      body: Scrollbar(
        child: VxBox(child: LayoutBuilder(
          builder: (context, constraints) {
            var parentHeight = constraints.maxHeight.round();
            var parentWidth = constraints.maxWidth.round();
            return VxScrollVertical(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodScreen()));
                    },
                    child: VxBox(
                            child: Column(
                      children: [
                        VxArc(
                          height: 10,
                          edge: VxEdge.BOTTOM,
                          child: VxBox(
                                  child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: Image.network(
                              "https://www.welcomenepal.com/uploads/activity/food-culinary_3.jpeg",
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                    child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ));
                              },
                              fit: BoxFit.cover,
                            ),
                          ))
                              .height(parentHeight * 0.4 * 0.80)
                              .width(parentWidth * 0.9)
                              .roundedLg
                              .make(),
                        ),
                        VxArc(
                            arcType: VxArcType.CONVEY,
                            edge: VxEdge.TOP,
                            height: 20,
                            child: VxBox(
                                    child: Center(
                              child: "Food you should try"
                                  .text
                                  .bold
                                  .xl
                                  .color(context.accentColor)
                                  .make(),
                            ))
                                .color(context.cardColor)
                                .width(parentWidth * 0.9)
                                .height(parentHeight * 0.4 * 0.2)
                                .bottomRounded()
                                .make())
                      ],
                    ))
                        .color(context.cardColor)
                        .roundedLg
                        .height(parentHeight * 0.4)
                        .width(parentWidth * 0.9)
                        .shadowMd
                        .make()
                        .py12(),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FestivalScreen()));
                    },
                    child: VxBox(
                            child: Column(
                      children: [
                        VxArc(
                            height: 10,
                            arcType: VxArcType.CONVEX,
                            edge: VxEdge.BOTTOM,
                            child: VxBox(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: Image.network(
                                    "https://img.traveltriangle.com/blog/wp-content/uploads/2017/10/gai-jatra-nepal-kb6592.jpeg",
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                          child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ));
                                    },
                                  )),
                            )
                                .height(parentHeight * 0.4 * 0.8)
                                .width(parentWidth * 0.9)
                                .make()),
                        VxArc(
                            height: 20,
                            edge: VxEdge.TOP,
                            arcType: VxArcType.CONVEY,
                            child: VxBox(
                                    child: Center(
                                        child: "Festival"
                                            .text
                                            .bold
                                            .xl2
                                            .color(context.accentColor)
                                            .make()))
                                .height(parentHeight * 0.4 * 0.2)
                                .width(parentWidth * 0.9)
                                .color(context.cardColor)
                                .bottomRounded()
                                .make())
                      ],
                    ))
                        .color(context.cardColor)
                        .roundedLg
                        .height(parentHeight * 0.4)
                        .width(parentWidth * 0.9)
                        .shadowMd
                        .make()
                        .py12(),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Emergencypage())),
                    child: VxBox(
                            child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.contact_phone_rounded,
                          size: MediaQuery.of(context).size.width*0.2,
                          color: Colors.blue,
                        ),
                        "Emergeny Contact"
                            .text
                            .color(Colors.blue)
                            .xl2
                            .bold
                            .make()
                      ],
                    ))
                        .color(context.cardColor)
                        .height(parentHeight * 0.165)
                        .shadowMd
                        .roundedLg
                        .width(parentWidth * 0.9)
                        .make()
                        .py12(),
                  ),
                ],
              ),
            );
          },
        ))
            .height(MediaQuery.of(context).size.height)
            .width(MediaQuery.of(context).size.width)
            .make(),
      ),
    );
  }
}
