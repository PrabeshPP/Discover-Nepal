import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/models/bagmatimodel.dart';
import 'package:nepaltourisguide/models/moreImages.dart';
import 'package:nepaltourisguide/screens/detail_homepage1-Prabesh.dart';

import 'package:nepaltourisguide/utils/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class BagmatiProvince extends StatefulWidget {
  const BagmatiProvince({Key? key}) : super(key: key);

  @override
  _BagmatiProvinceState createState() => _BagmatiProvinceState();
}

class _BagmatiProvinceState extends State<BagmatiProvince> {
  @override
  void initState() {
    super.initState();
    loadDataB();
  }

  loadDataB() async {
    await Future.delayed(Duration(seconds: 1));
    final jsonFileB =
        await rootBundle.loadString("Assets/files/bagmatiprovince.json");

    final decodeFileB = jsonDecode(jsonFileB);
    var listDataB = decodeFileB["bagmati"];

    var listDataBB = decodeFileB["More Images"];
    var listDataBBB = decodeFileB["Weather Name"];
    BagmatiModel.bagmatiitems = List.from(listDataB)
        .map<BagmatiItems>((xb) => BagmatiItems.fromMap(xb))
        .toList();
    MoreImagesModel.moreimages = List.from(listDataBB)
        .map<MoreImages>((xbb) => MoreImages.fromMap(xbb))
        .toList();
    WeatherName3Model.weathername3 = List.from(listDataBBB)
        .map<WeatherName3>((xbbb) => WeatherName3.fromMap(xbbb))
        .toList();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: context.canvasColor,
          title: "Popular Destinations"
              .text
              .color(context.accentColor)
              .bold
              .make(),
        ),
        body: PageUI());
  }
}

Widget PageUI() {
  return Consumer<ConnectivityProvider>(builder: (context, model, child) {
    if (model.isOnline == true) {
      return VxBox(
              child: (BagmatiModel.bagmatiitems != null &&
                      BagmatiModel.bagmatiitems!.isNotEmpty)
                  ? BagmatiList()
                  : Center(child: CircularProgressIndicator()))
          .color(context.canvasColor)
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

class BagmatiList extends StatelessWidget {
  const BagmatiList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: BagmatiModel.bagmatiitems!.length,
        itemBuilder: (context, index) {
          final catalogB = BagmatiModel.bagmatiitems![index];
          final moreImages = MoreImagesModel.moreimages![index];
          final weatherName3 = WeatherName3Model.weathername3![index];
          return Bagamatiitems(
              catalogB: catalogB,
              moreImages: moreImages,
              weatherName3: weatherName3);
        });
  }
}

class Bagamatiitems extends StatelessWidget {
  final catalogB;
  final moreImages;
  final weatherName3;
  const Bagamatiitems(
      {Key? key, this.catalogB, this.moreImages, this.weatherName3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailHomepage1(
                image: catalogB.image.toString(),
                    desc: catalogB.desc.toString(),
                    name: catalogB.name.toString(),
                    Moreimg: moreImages,
                    Weather1: weatherName3,
                  ))),
      child: Card(
        color: context.canvasColor,
        elevation: 20,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GridTile(
            child: Container(
              height: 200,
              width: 150,
              color: context.canvasColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  catalogB.image.toString(),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }return Center(
                      child:CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes!=null?
                      loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes
                      !:null,
                      ));
                  },
                ).pOnly(bottom: 15),
              ),
            ),
            footer: VxBox(
                    child: catalogB.name
                        .toString()
                        .text
                        .bold
                        .color(context.accentColor)
                        .make()
                        .pOnly(left: 4))
                .color(context.cardColor)
                .bottomRounded()
                .make()
                ),
      ),
    );
  }
}
