import 'package:flutter/material.dart';
import 'package:noviindus/helper/navigation.dart';
import 'package:noviindus/views/homePage.dart';
import 'package:provider/provider.dart';

import 'provider/newProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
     ChangeNotifierProvider(create: ((context) => NewsProvider()))
      
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            home: HomePage());
  }
}

