import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepaltourisguide/API/weatherApi.dart';
import 'package:nepaltourisguide/models/weathermodel.dart';
import 'package:velocity_x/velocity_x.dart';

class MyWeather extends StatefulWidget {
  final Weather1;
  final String name;
  const MyWeather({Key? key, this.Weather1, required this.name})
      : super(key: key);

  @override
  _MyWeatherState createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  late Future<WeatherResponse> weatherresponse;
  final dataservice = Dataservice();
  final realtime = DateFormat("hh:mm a").format(DateTime.now());
  final time = DateTime.now();
  String? BGimg;

  @override
  void initState() {
    super.initState();
    weatherresponse = dataservice.loadData(widget.Weather1.name.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (time.hour >= 6 && time.hour < 18) {
      BGimg = "Assets/Images/sunny.jpg";
    } else if (time.hour >= 18 && time.hour < 19) {
      BGimg = "Assets/Images/evening.jpg";
    } else if (time.hour < 6 || time.hour >= 19) {
      BGimg = "Assets/Images/night.jpg";
    }
    ;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      body: VxBox(
          child: FutureBuilder<WeatherResponse>(
        future: weatherresponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final icon = snapshot.data!.icon;
            final url =
                "http://openweathermap.org/img/wn/${icon.toString()}@2x.png";
            final String mainx = snapshot.data!.main;
            if (mainx == "Rain" || mainx == "Drizzle") {
              BGimg = "Assets/Images/rainy.jpg";
            } else if (mainx == "Thunderstorm") {
              BGimg = "Assets/Images/thunderstorm.jpg";
            } else if (mainx == "Snow") {
              BGimg = "Assets/Images/snow.jpg";
            }
            return Stack(
              children: <Widget>[
                Image.asset(
                  BGimg!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.black38),
                ),
                Positioned(
                    left: 10,
                    top: 70,
                    child: VxBox(
                        child: Row(
                      children: [
                        "${realtime}".text.xl2.color(Colors.white).make()
                      ],
                    )).make()),
                Positioned(
                    left: 10,
                    top: 100,
                    child: VxBox(
                        child: Row(
                      children: [
                        Flexible(
                            flex: 2,
                            child: Container(
                                child: "${widget.name}"
                                    .text
                                    .color(Colors.white)
                                    .xl3
                                    .make()))
                      ],
                    )).width(MediaQuery.of(context).size.width).make()),
                Positioned(
                    top: 190,
                    left: 0,
                    child: VxBox(
                        child: Row(
                      children: [
                        VxBox(
                            child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        )).square(120).make()
                      ],
                    )).make()),
                Positioned(
                    top: 300,
                    left: 10,
                    child: VxBox(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "${snapshot.data!.temp.round()} °C"
                                  .text
                                  .xl6
                                  .bold
                                  .color(Colors.white)
                                  .make(),
                              "${snapshot.data!.humidity} g.m-3"
                                  .text
                                  .color(Colors.white)
                                  .xl2
                                  .make()
                                  .pOnly(left: 40)
                            ]),
                        "${snapshot.data!.description}"
                            .text
                            .color(Colors.white)
                            .xl4
                            .make(),
                      ],
                    )).make()),
                Positioned(
                    top: 450,
                    left: 10,
                    child: VxBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.arrow_up,
                          color: Colors.white,
                          size: 25,
                        ),
                        "${snapshot.data!.temp_max.round()} °C"
                            .text
                            .color(Colors.white)
                            .xl
                            .make()
                            .pOnly(left: 10),
                        Icon(
                          CupertinoIcons.arrow_down,
                          color: Colors.white,
                          size: 25,
                        ).pOnly(left: 15),
                        "${snapshot.data!.temp_min.round() - 5} °C"
                            .text
                            .color(Colors.white)
                            .xl
                            .make(),
                      ],
                    )).make()),
                Positioned(
                    top: 530,
                    left: 10,
                    child: VxBox(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.wind,
                          color: Colors.white,
                          size: 30,
                        ),
                        "${snapshot.data!.speed}"
                            .text
                            .color(Colors.white)
                            .xl3
                            .make()
                            .pOnly(left: 10),
                        VxBox(
                          child: Image.network(
                            "https://cdn.iconscout.com/icon/premium/png-512-thumb/air-pressure-1424009-1204225.png",
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                        ).square(40).make().pOnly(left: 15, bottom: 10),
                        "${snapshot.data!.pressure / 1000} kPa"
                            .text
                            .color(Colors.white)
                            .xl3
                            .make(),
                      ],
                    )).make())
              ],
            );
          } else if (snapshot.hasError) {
            return  NoInternet();
          }
          return Center(
              child: CircularProgressIndicator(
                  // color: context.accentColor,
                  ));
        },
      )).make(),
    );
    
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

