import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hues_dovui/src/presentation/home/home_screen.dart';
import 'package:hues_dovui/src/resource/repository/other_repository.dart';
import 'package:hues_dovui/src/routers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider.value(
      value: OtherRepository(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
