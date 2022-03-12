import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/models/moreImages.dart';
import 'package:nepaltourisguide/models/province2model.dart';
import 'package:nepaltourisguide/screens/detail_homepage1-Prabesh.dart';

import 'package:nepaltourisguide/utils/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Province2 extends StatefulWidget {
  const Province2({Key? key}) : super(key: key);

  @override
  _Province2State createState() => _Province2State();
}

class _Province2State extends State<Province2> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final jsonData2 =
        await rootBundle.loadString("Assets/files/province2.json");
    final decodeData2 = jsonDecode(jsonData2);
    var listData2 = decodeData2["popular2"];
    var listData22 = decodeData2["More Photos"];
    var listData222 = decodeData2["Weather Name"];
    Province2Model.province2 = List.from(listData2)
        .map<Province22>((x) => Province22.fromMap(x))
        .toList();
    MoreImagesModel.moreimages = List.from(listData22)
        .map<MoreImages>((x2) => MoreImages.fromMap(x2))
        .toList();
    WeatherName2Model.weathername2 = List.from(listData222)
        .map<WeatherName2>((x3) => WeatherName2.fromMap(x3))
        .toList();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        centerTitle: true,
        title: "Popular Places".text.color(context.accentColor).bold.make(),
      ),
      body: PageUI(),
    );
  }
}

Widget PageUI() {
  return Consumer<ConnectivityProvider>(builder: (context, model, child) {
    if (model.isOnline == true) {
      return VxBox(
              child: (Province2Model.province2 != null &&
                      Province2Model.province2!.isNotEmpty)
                  ? ListBuilder2()
                  : Center(child: CircularProgressIndicator()))
          .color(context.canvasColor)
          .make()
          .pOnly(top: 20);
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

class ListBuilder2 extends StatelessWidget {
  const ListBuilder2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: Province2Model.province2!.length,
        itemBuilder: (context, index) {
          final item = Province2Model.province2![index];
          final MoreImages2 = MoreImagesModel.moreimages![index];
          final weathername2 = WeatherName2Model.weathername2![index];
          return Province2Items(
            item: item,
            MoreImages2: MoreImages2,
            weatherName2: weathername2,
          );
        });
  }
}

class Province2Items extends StatelessWidget {
  final item;
  final MoreImages2;
  final weatherName2;
  const Province2Items(
      {Key? key, this.item, this.MoreImages2, this.weatherName2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailHomepage1(
                image: item.image.toString(),
                    desc: item.desc.toString(),
                    name: item.name.toString(),
                    Moreimg: MoreImages2,
                    Weather1: weatherName2,
                  ))),
      child: Card(
        elevation: 20,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GridTile(
          child: Container(
            color: context.canvasColor,
            height: 200,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.image.toString(),
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
                  child: item.name
                      .toString()
                      .text
                      .bold
                      .color(context.accentColor)
                      .make()
                      .pOnly(left: 6))
              .color(context.cardColor)
              .bottomRounded()
              .make(),
        ),
      ),
    );
  }
}
