import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/models/emergencymodel.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergencypage extends StatefulWidget {
  const Emergencypage({Key? key}) : super(key: key);

  @override
  _EmergencypageState createState() => _EmergencypageState();
}

class _EmergencypageState extends State<Emergencypage> {
  @override
  void initState() {
    super.initState();
    loadDataE();
  }

  loadDataE() async {
    final emergencyData =
        await rootBundle.loadString("Assets/files/emergencycontact.json");
    final decodeEmergencyData = jsonDecode(emergencyData);
    var dataE = decodeEmergencyData["Emergency Contacts"];
    EmergencyModel.emergency =
        List.from(dataE).map<Emergency>((xe) => Emergency.fromMap(xe)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.canvasColor,
          title:
              "Emergency contact".text.color(context.accentColor).bold.make(),
        ),
        body: (EmergencyModel.emergency != null &&
                EmergencyModel.emergency!.isNotEmpty)
            ? EmergencyList()
            : Center(child: CircularProgressIndicator()));
  }
}

class EmergencyList extends StatelessWidget {
  const EmergencyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: EmergencyModel.emergency!.length,
        itemBuilder: (BuildContext, index) {
          final EData = EmergencyModel.emergency![index];
          return EmergencyItems(
            E_data: EData,
          );
        });
  }
}

class EmergencyItems extends StatelessWidget {
  final Emergency? E_data;

  const EmergencyItems({Key? key, this.E_data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teal = Colors.indigo[100];
    return VxBox(
      child: InkWell(
        onTap: () {
          _makingPhoneCall(number: E_data!.contact);
        },
        child: VxBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "${E_data!.name}"
                  .text
                  .xl
                  .bold
                  .color(Colors.black)
                  .make()
                  .pOnly(top: 12, bottom: 12, left: 5),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 35,
                    color: Colors.blue,
                  ).px(12),
                  "${E_data!.contact}".text.color(Colors.black).xl2.bold.make()
                ],
              )
            ],
          ),
        ).square(150).color(teal!).shadowLg.rounded.make().p12(),
      ),
    )
        .color(context.canvasColor)
        .height(150)
        .width(MediaQuery.of(context).size.width)
        .make();
  }
}

_makingPhoneCall({number}) async {
  var phoneNumber = number;
  var url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
