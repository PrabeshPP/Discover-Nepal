import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Nothing extends StatelessWidget {
  const Nothing({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
      ),
      body: VxBox(
        child: SingleChildScrollView(
          child: Column(
            
            
            children: [
             Center(child:
              VxBox(child: Icon(CupertinoIcons.wifi_exclamationmark,
              size: 100,
              color: Colors.red,)
              ).square(200).make()),
              "Oops! No internet".text.color(context.accentColor).xl3.make()
        
                        ],
          ),
        )
      ).color(context.canvasColor).make(),
    );
  }
}