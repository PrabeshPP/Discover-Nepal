import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/models/moreImages.dart';
import 'package:nepaltourisguide/models/province1model.dart';
import 'package:nepaltourisguide/models/weathername1.dart';
import 'package:nepaltourisguide/screens/detail_homepage1-Prabesh.dart';

import 'package:nepaltourisguide/utils/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class PopularDestinations extends StatefulWidget {
  const PopularDestinations({Key? key}) : super(key: key);

  @override
  _PopularDestinationsState createState() => _PopularDestinationsState();
}

class _PopularDestinationsState extends State<PopularDestinations> {
  @override
  void initState() {
    super.initState();
    loadPopularData();
  }

  loadPopularData() async {
    await Future.delayed(Duration(seconds: 0));
    final popularJsonfile =
        await rootBundle.loadString("Assets/files/province1.json");
    final decodeDaTa = jsonDecode(popularJsonfile);
    var ListDatA = decodeDaTa["popular"];
    var ListDatAimg = decodeDaTa["More photos"];
    var ListWeatherName1 = decodeDaTa["weathername"];
    PopularModel.popularitem = List.from(ListDatA)
        .map<PopularItems>((item) => PopularItems.fromMap(item))
        .toList();
    MoreImagesModel.moreimages = List.from(ListDatAimg)
        .map<MoreImages>((x) => MoreImages.fromMap(x))
        .toList();
    WeatherModel1.weathername1 = List.from(ListWeatherName1)
        .map<WeatherName1>((x1) => WeatherName1.fromMap(x1))
        .toList();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Popular Destinations"
              .text
              .color(context.accentColor)
              .fontWeight(FontWeight.bold)
              .make(),
          backgroundColor: context.canvasColor,
        ),
        body: PageUI1());
  }
}

Widget PageUI1() {
  return Consumer<ConnectivityProvider>(builder: (context, model, child) {
    if (model.isOnline == true) {
      return VxBox(
              child: (PopularModel.popularitem != null &&
                      PopularModel.popularitem!.isNotEmpty)
                  ? PopularList()
                  : Center(child: CircularProgressIndicator()))
          .make();
    } else {
      return VxBox(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: VxBox(
                  child: Icon(
            CupertinoIcons.wifi_exclamationmark,
            size: 100,
            color: Colors.red,
          )).square(200).make()),
          "Oops! No internet".text.color(context.accentColor).xl3.make()
        ],
      )).color(context.canvasColor).make();
    }
  });
}

class PopularList extends StatelessWidget {
  const PopularList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 12, crossAxisCount: 2, crossAxisSpacing: 12),
        itemCount: PopularModel.popularitem!.length,
        itemBuilder: (context, index) {
          final cat = PopularModel.popularitem![index];
          final MoreImg = MoreImagesModel.moreimages![index];
          final Weather1 = WeatherModel1.weathername1![index];
          return PopularItems1(
            cat: cat,
            MoreImg: MoreImg,
            Weather1: Weather1,
          );
        });
  }
}

class PopularItems1 extends StatelessWidget {
  final cat;
  final MoreImg;
  final Weather1;
  const PopularItems1({Key? key, this.cat, this.MoreImg, this.Weather1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailHomepage1(
                      name: cat.name.toString(),
                      Moreimg: MoreImg,
                      Weather1: Weather1,
                      desc: cat.desc.toString(),
                      image: cat.image.toString(),
                    )));
      },
      child: Card(
        elevation: 20,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GridTile(
          child: Container(
              color: context.canvasColor,
              height: 150,
              width: 200,
              child: Image.network(
                cat.image.toString(),
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
              ).pOnly(bottom: 15)),
          footer: Container(
            color: context.cardColor,
            child: Text(
              cat.name.toString(),
              style: TextStyle(
                  color: context.accentColor, fontWeight: FontWeight.bold),
            ).pOnly(left: 6),
          ),
        ),
      ),
    );
  }
}
