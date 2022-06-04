import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepaltourisguide/PopularDestinations/bagmati.dart';
import 'package:nepaltourisguide/PopularDestinations/province2.dart';
import 'package:nepaltourisguide/Sub_screens/traveldesk.dart';
import 'package:nepaltourisguide/routes/routes.dart';
import 'package:nepaltourisguide/screens/auth.dart';
import 'package:nepaltourisguide/screens/homepage.dart';
import 'package:nepaltourisguide/screens/nthg.dart';
import 'package:nepaltourisguide/PopularDestinations/province1.dart';
import 'package:nepaltourisguide/screens/signup.dart';
import 'package:nepaltourisguide/utils/connectivity_provider.dart';
import 'package:nepaltourisguide/utils/store.dart';
import 'package:nepaltourisguide/widget/theme-Prabesh.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VxState(store: MyStore(), child: MyApp()));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ConnectivityProvider(), 
              child: Homepage()),
          ChangeNotifierProvider(
            create: (contexT) => ConnectivityProvider(),
            child: PopularDestinations(),
          )
        ],
        child: MaterialApp(
          home: Homepage(),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: Mytheme.lightTheme(context),
          darkTheme: Mytheme.darkTheme(context),
          initialRoute: Routes.homePage,
          routes: {
            Routes.popularDestination: (context) => PopularDestinations(),
            Routes.nthg: (context) => Nothing(),
            Routes.prov2: (context) => Province2(),
            Routes.bagmati: (context) => BagmatiProvince(),
            Routes.traveldesk: (context) => TravelDesk(),
            Routes.auth: (context) => Authentication(),
            Routes.signup: (context) => SignUp()
          },
        ));
  }
}
