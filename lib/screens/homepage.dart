import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/PopularDestinations/gandaki-Prabesh.dart';
import 'package:nepaltourisguide/PopularDestinations/karnali-Prabesh.dart';
import 'package:nepaltourisguide/PopularDestinations/lumbini-Prabesh.dart';
import 'package:nepaltourisguide/PopularDestinations/sudhurpaschim-Prabesh.dart';

import 'package:nepaltourisguide/models/statemodel.dart';
import 'package:nepaltourisguide/routes/routes.dart';
import 'package:nepaltourisguide/utils/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final uid;

  const Homepage({Key? key, this.uid}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    loadData();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  loadData() async {
    final jsonData =
        await rootBundle.loadString("Assets/files/state/State.json");
    final decodeData = jsonDecode(jsonData);
    var productiondata = decodeData["stateData"];
    CartModel.item = List.from(productiondata)
        .map<Items>((item) => Items.fromMap(item))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: context.canvasColor));
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: context.canvasColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Discover Nepal",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: pageUI());
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline == true) {
        return Container(
          decoration: BoxDecoration(color: context.canvasColor),
          child: Column(
            children: [
              if (CartModel.item != null && CartModel.item!.isNotEmpty)
                ItemList().p12().expand()
              else
                Center(
                  child: CircularProgressIndicator().pOnly(top: 300),
                )
            ],
          ),
        );
      } else {
        return Stack(children: [
          Container(
            child: Column(
              children: [
                if (CartModel.item != null && CartModel.item!.isNotEmpty)
                  ItemList().p12().expand()
                else
                  Center(
                    child: CircularProgressIndicator().pOnly(top: 300),
                  )
              ],
            ),
          ),
          Positioned(
              top: 700,
              child: VxBox(
                      child: Center(
                child: "No Internet!Connect to Wifi or Cellular Network."
                    .text
                    .color(Colors.white)
                    .make(),
              ))
                  .color(Colors.red)
                  .height(MediaQuery.of(context).size.height * 0.03)
                  .width(MediaQuery.of(context).size.width)
                  .make())
        ]);
      }
    });
  }
}

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: CartModel.item!.length,
        itemBuilder: (context, index) {
          final catalog = CartModel.item![index];
          final num index1 = index;
          return CatalogItem(
            catalog: catalog,
            index1: index1,
          );
        });
  }
}

class CatalogItem extends StatelessWidget {
  final catalog;
  final index1;
  const CatalogItem({Key? key, this.catalog, this.index1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (index1 == 0)
          Navigator.pushNamed(context, Routes.popularDestination);
        else if (index1 == 1)
          Navigator.pushNamed(context, Routes.prov2);
        else if (index1 == 2)
          Navigator.pushNamed(context, Routes.bagmati);
        else if (index1 == 3)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GandakiProvince()));
        else if (index1 == 4)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LumbiniProvince()));
        else if (index1 == 5)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => karnaliProvince()));
        else if (index1 == 6)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SudhurPaschimProvince()));
      },
      child: VxBox(
              child: Row(
        children: [
          VxBox(
                  child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              catalog.image.toString(),
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
            ),
          ))
              .width(180)
              .height(150)
              .color(context.cardColor)
              .make()
              .pOnly(left: 8, bottom: 8, right: 8, top: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(catalog.name.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w900))
              ],
            ),
          )
        ],
      ))
          .color(context.cardColor)
          .height(150)
          .width(600)
          .shadowLg
          .roundedLg
          .make()
          .p12(),
    );
  }
}
