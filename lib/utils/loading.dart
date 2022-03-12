import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';


 class Loading extends StatelessWidget {
   const Loading({ Key? key }) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     return Container(
       color: context.canvasColor,
       child: Center(
         child:SpinKitPouringHourGlassRefined(
           
           color:Colors.red,
           size: 100.0, )),
       
     );
   }
 }