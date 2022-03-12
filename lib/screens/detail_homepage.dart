import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepaltourisguide/Sub_screens/hotel.dart';
import 'package:nepaltourisguide/Sub_screens/map.dart';
import 'package:nepaltourisguide/Sub_screens/placedesc.dart';
import 'package:nepaltourisguide/Sub_screens/traveldesk.dart';
import 'package:nepaltourisguide/Sub_screens/weather.dart';
import 'package:velocity_x/velocity_x.dart';

class HomedetailPage extends StatefulWidget {
  final String desc;
  final String name;
  final String image;
  final Moreimg;
  final Weather1;

  const HomedetailPage(
      {Key? key, required this.name, this.Moreimg, this.Weather1,required  this.desc,required this.image})
      : super(key: key);

  @override
  _HomedetailPageState createState() => _HomedetailPageState();
}

class _HomedetailPageState extends State<HomedetailPage> {
  num index1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            "${widget.name}".text.bold.color(context.accentColor).make().p12(),
        backgroundColor: context.canvasColor,
      ),
      body: SafeArea(
        bottom: false,
        child: VxBox(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: <Widget>[
                VxBox(
                  child: Column(children: [
                    VxSwiper.builder(
                        itemCount: 3,
                        reverse: false,
                        isFastScrollingEnabled: false,
                        initialPage: 0,
                        aspectRatio: 30 / 20,
                        enableInfiniteScroll: false,
                        viewportFraction: 1.01,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          setState(() {
                            index1 = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return VxBox(
                            child: Column(
                              children: [
                                if (index1 == 0)
                                  CachedNetworkImage(
                                      imageUrl: widget.Moreimg.img1.toString(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            )),
                                          ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator()
                                              .pOnly(top: 90),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error))
                                else if (index1 == 1)
                                  CachedNetworkImage(
                                      imageUrl: widget.Moreimg.img2.toString(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            )),
                                          ),
                                      placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()
                                                .pOnly(top: 90),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error))
                                else if (index1 == 2)
                                  CachedNetworkImage(
                                      imageUrl: widget.Moreimg.img3.toString(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            )),
                                          ),
                                      placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()
                                                .pOnly(top: 90),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error))
                              ],
                            ),
                          )
                              .color(context.canvasColor)
                              .height(MediaQuery.of(context).size.height * 0.4)
                              .make()
                              .px1();
                        }),
                  ]),
                ).color(context.cardColor).make(),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.44,
                  bottom: 20,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: VxBox(
                            child: "${index1 + 1}/3"
                                .text
                                .center
                                .color(context.accentColor)
                                .make()
                                .pOnly(top: 5))
                        .color(context.cardColor)
                        .rounded
                        .make()
                        .wh(40, 30),
                  ),
                ),
              ]),
              5.heightBox,
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapPage(
                              address: widget.name,
                            ))),
                child: VxBox(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 40,
                      color: Colors.blue,
                    ),
                    "Map".text.color(context.accentColor).bold.make()
                  ],
                ))
                    .color(context.cardColor)
                    .roundedLg
                    .square(100)
                    .shadowLg
                    .make(),
              ),
              12.heightBox,
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Hotel()));
                },
                child: VxBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.hotel, size: 40, color: Colors.blue)
                                .pOnly(top: 8),
                            "Hotel"
                                .text
                                .color(context.accentColor)
                                .bold
                                .make()
                                .p12()
                          ]),
                    )
                        .color(context.cardColor)
                        .roundedLg
                        .square(100)
                        .shadowLg
                        .make(),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyWeather(
                                  Weather1: widget.Weather1,
                                  name: widget.name))),
                      onLongPress: () => VxToast.show(context,
                          msg: "Weather",
                          bgColor: context.cardColor,
                          textColor: context.accentColor,
                          position: VxToastPosition.center),
                      child: VxBox(
                              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.cloud_sun_fill,
                            size: 40,
                            color: Colors.orange,
                          ).pOnly(top: 8),
                          "Weather"
                              .text
                              .color(context.accentColor)
                              .bold
                              .make()
                              .p12()
                        ],
                      ))
                          .color(context.cardColor)
                          .shadowLg
                          .square(100)
                          .roundedLg
                          .make(),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TravelDesk())),
                      child: VxBox(
                              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.my_library_books_sharp,
                            color: Colors.blue,
                            size: 40,
                          ).pOnly(top: 10),
                          "Travel Desk"
                              .text
                              .bold
                              .color(context.accentColor)
                              .make()
                              .pOnly(top: 10)
                        ],
                      ))
                          .color(context.cardColor)
                          .shadowLg
                          .roundedLg
                          .square(100)
                          .make(),
                    )
                  ],
                )).make(),
              ),
              12.heightBox,
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PlaceDesc(
                        desc: widget.desc,
                        name: widget.name,
                        image: widget.image,
                      )));
                },
                child: VxBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VxBox(
                            child: Column(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Icon(
                            Icons.description_rounded,
                            size: 40,
                            color: Colors.blue,
                          ).pOnly(top: 8),
                        ),
                        "Description"
                            .text
                            .color(context.accentColor)
                            .bold
                            .make()
                            .pOnly(top: 10, bottom: 10, right: 10, left: 10),
                      ],
                    ))
                        .color(context.cardColor)
                        .alignCenter
                        .shadowLg
                        .roundedLg
                        .square(100)
                        .make()
                        .px1()
                  ],
                )).make().pOnly(bottom: 12),
              ),
            ],
          ),
        )).color(context.canvasColor).make(),
      ),
    );
  }
}
