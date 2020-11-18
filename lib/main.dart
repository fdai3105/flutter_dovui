import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hues_dovui/src/presentation/home/home_screen.dart';
import 'package:hues_dovui/src/presentation/home/home_viewmodel.dart';
import 'package:hues_dovui/src/presentation/more_app/more.dart';
import 'package:hues_dovui/src/presentation/play/play.dart';
import 'package:hues_dovui/src/resource/repository/other_repository.dart';
import 'package:hues_dovui/src/resource/service/SoundService.dart';
import 'package:hues_dovui/src/routers.dart';
import 'package:hues_dovui/src/utlis/shared_pref.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);

  await SharedPref.instance();
  await SoundService.init();
  await SoundService().playSound(GameSound.Music);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<PlayViewModel>(
      create: (_) => PlayViewModel(),
      child: PlayScreen(),
    ),
    ChangeNotifierProvider<MoreAppViewModel>(
      create: (_) => MoreAppViewModel(),
      child: MoreAppScreen(),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child: HomeScreen(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
