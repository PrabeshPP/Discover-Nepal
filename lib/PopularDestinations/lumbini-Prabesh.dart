import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/models/bagmatimodel.dart';
import 'package:nepaltourisguide/models/lumbinimodel.dart';
import 'package:nepaltourisguide/models/moreImages.dart';
import 'package:nepaltourisguide/screens/detail_homepage1-Prabesh.dart';

import 'package:nepaltourisguide/utils/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class LumbiniProvince extends StatefulWidget {
  const LumbiniProvince({Key? key}) : super(key: key);

  @override
  _LumbiniProvinceState createState() => _LumbiniProvinceState();
}

class _LumbiniProvinceState extends State<LumbiniProvince> {
  @override
  void initState() {
    super.initState();
    loadDataB();
  }

  loadDataB() async {
    await Future.delayed(Duration(seconds: 1));
    final jsonFileL =
        await rootBundle.loadString("Assets/files/lumbiniprovince.json");

    final decodeFileL = jsonDecode(jsonFileL);
    var listDataL = decodeFileL["lumbiniProvince"];

    var listDataLL = decodeFileL["More Images"];
    var listDataLLL = decodeFileL["Weather Name"];
    LumbiniModel.lumbini =
        List.from(listDataL).map<Lumbini>((xL) => Lumbini.fromMap(xL)).toList();
    MoreImagesModel.moreimages = List.from(listDataLL)
        .map<MoreImages>((xbb) => MoreImages.fromMap(xbb))
        .toList();
    WeatherName3Model.weathername3 = List.from(listDataLLL)
        .map<WeatherName3>((xbbb) => WeatherName3.fromMap(xbbb))
        .toList();
    if(mounted)setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.canvasColor,
          centerTitle: true,
          title:
              "Popular Places".text.xl.bold.color(context.accentColor).make(),
        ),
        body: PageUI());
  }
}

Widget PageUI() {
  return Consumer<ConnectivityProvider>(builder: (context, model, child) {
    if (model.isOnline == true) {
      return VxBox(
              child: (LumbiniModel.lumbini != null &&
                      LumbiniModel.lumbini!.isNotEmpty)
                  ? LumbiniList()
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

class LumbiniList extends StatelessWidget {
  const LumbiniList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: LumbiniModel.lumbini!.length,
        itemBuilder: (context, index) {
          final catalogG = LumbiniModel.lumbini![index];
          final moreImages = MoreImagesModel.moreimages![index];
          final weatherName4 = WeatherName3Model.weathername3![index];
          return LumbiniItems(
              catalogG: catalogG,
              moreImages: moreImages,
              weatherName4: weatherName4);
        });
    
  }
}

class LumbiniItems extends StatelessWidget {
  final catalogG;
  final moreImages;
  final weatherName4;
  const LumbiniItems(
      {Key? key, this.catalogG, this.moreImages, this.weatherName4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailHomepage1(
                image: catalogG.image.toString(),
                desc: catalogG.desc.toString(),
                    name: catalogG.name.toString(),
                    Moreimg: moreImages,
                    Weather1: weatherName4,
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
                  catalogG.image.toString(),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ).pOnly(bottom: 15),
              ),
            ),
            footer: VxBox(
                    child: catalogG.name
                        .toString()
                        .text
                        .bold
                        .color(context.accentColor)
                        .make()
                        .pOnly(left: 4))
                .color(context.cardColor)
                .bottomRounded()
                .make()),
      ),
    );
    
  }
}
