import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';



class Mytheme {
  static lightTheme(BuildContext context) => ThemeData(
      primaryColor: Colors.black,
      cardColor: Colors.white,
      canvasColor: creamColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
         systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark
           ), toolbarTextStyle: Theme.of(context).textTheme.bodyText2, titleTextStyle: Theme.of(context).textTheme.headline6
      ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(secondary: darkBluishColor),
    
    
      

      
      );

  static darkTheme(BuildContext context) => ThemeData(
    primaryColor: Colors.white,
      cardColor: Colors.black,
      canvasColor: darkCreamColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
        // ignore: deprecated_member_use
        brightness: Brightness.dark,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white), toolbarTextStyle: Theme.of(context).textTheme.copyWith(
            headline6:
                context.textTheme.headline6!.copyWith(color: Colors.white)).bodyText2, titleTextStyle: Theme.of(context).textTheme.copyWith(
            headline6:
                context.textTheme.headline6!.copyWith(color: Colors.white)).headline6,
      ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.white));

  static Color creamColor = Color(0xfff5f5f5);
  static Color darkBluishColor = Color(0xff403b58);
  static Color darkCreamColor = Vx.gray900;
  static Color lightBluishColor = Vx.blueGray800;
}
