import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/Sub_screens/desc.dart';
import 'package:nepaltourisguide/models/foodmodel.dart';
import 'package:velocity_x/velocity_x.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final loadjsonfile = await rootBundle.loadString("Assets/files/food.json");
    final decodeJsonFile = jsonDecode(loadjsonfile);
    var foodFile = decodeJsonFile["Food"];
    FoodModel.food =
        List.from(foodFile).map<Food>((e) => Food.fromMap(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Food".text.bold.color(context.accentColor).make(),
        backgroundColor: context.canvasColor,
      ),
      body: (FoodModel.food != null && FoodModel.food!.isNotEmpty)
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: FoodModel.food!.length,
              itemBuilder: (context, index) {
                final food = FoodModel.food![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Description(
                                  name: food.name,
                                  image: food.image,
                                  desc: food.desc,
                                )));
                  },
                  child: Card(
                    elevation: 20.0,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight:Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)
                        )),
                    child: GridTile(
                        child: VxBox(
                                child: Image.network(
                          food.image.toString(),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingprogress) {
                            if (loadingprogress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingprogress.expectedTotalBytes !=
                                        null
                                    ? loadingprogress.cumulativeBytesLoaded /
                                        loadingprogress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ))
                            .width(200)
                            .height(150)
                            .make()
                            .pOnly(bottom: 8),
                        footer: VxBox(
                           child: Center(
                                child: food.name.toString()
                                    .text
                                    .bold
                                    .xl
                                    .color(context.accentColor)
                                    .make())
                                    ).bottomRounded().color(context.cardColor).make()
                                    ),
                  ),
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
