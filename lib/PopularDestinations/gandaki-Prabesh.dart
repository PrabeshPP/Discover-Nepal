import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/models/bagmatimodel.dart';
import 'package:nepaltourisguide/models/gandakimodel.dart';
import 'package:nepaltourisguide/models/moreImages.dart';
import 'package:nepaltourisguide/screens/detail_homepage1-Prabesh.dart';

import 'package:nepaltourisguide/utils/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class GandakiProvince extends StatefulWidget {
  const GandakiProvince({Key? key}) : super(key: key);

  @override
  _GandakiProvinceState createState() => _GandakiProvinceState();
}

class _GandakiProvinceState extends State<GandakiProvince> {
  @override
  void initState() {
    super.initState();
    loadDataB();
  }

  loadDataB() async {
    await Future.delayed(Duration(seconds: 1));
    final jsonFileB =
        await rootBundle.loadString("Assets/files/gandakiprovince.json");

    final decodeFileG = jsonDecode(jsonFileB);
    var listDataG = decodeFileG["gandakiProvince"];

    var listDataGG = decodeFileG["More Images"];
    var listDataGGG = decodeFileG["Weather Name"];
    GandakiModel.gandaki =
        List.from(listDataG).map<Gandaki>((xG) => Gandaki.fromMap(xG)).toList();
    MoreImagesModel.moreimages = List.from(listDataGG)
        .map<MoreImages>((xbb) => MoreImages.fromMap(xbb))
        .toList();
    WeatherName3Model.weathername3 = List.from(listDataGGG)
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
              child: (GandakiModel.gandaki != null &&
                      GandakiModel.gandaki!.isNotEmpty)
                  ? GandakiList()
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

class GandakiList extends StatelessWidget {
  const GandakiList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: GandakiModel.gandaki!.length,
        itemBuilder: (context, index) {
          final catalogG = GandakiModel.gandaki![index];
          final moreImages = MoreImagesModel.moreimages![index];
          final weatherName4 = WeatherName3Model.weathername3![index];
          return GandakiItems(
              catalogG: catalogG,
              moreImages: moreImages,
              weatherName4: weatherName4);
        });
  
  }
}

class GandakiItems extends StatelessWidget {
  final catalogG;
  final moreImages;
  final weatherName4;
  const GandakiItems(
      {Key? key, this.catalogG, this.moreImages, this.weatherName4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailHomepage1(
                image: catalogG.img.toString(),
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
                  catalogG.img.toString(),
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
