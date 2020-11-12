import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/home/home.dart';
import 'package:hues_dovui/src/presentation/more_app/more_app_screen.dart';
import 'package:hues_dovui/src/presentation/play/play_screen.dart';

class Routers {
  static const String home = "/";
  static const String moreGame = "/more_game";
  static const String play = "/play";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final argus = settings.arguments;
    switch (settings.name) {
      case home:
        return animRoute(HomeScreen(), name: home, arguments: argus);
        break;
      case play:
        return animRoute(PlayScreen(), name: play, arguments: argus);
        break;
      case moreGame:
        return animRoute(MoreAppScreen(), name: moreGame, arguments: argus);
        break;
    }
  }

  static Route animRoute(Widget page,
      {Offset beginOffset, String name, Object arguments}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Offset center = Offset(0.0, 0.0);
  static Offset top = Offset(0.0, 1.0);
  static Offset bottom = Offset(0.0, -1.0);
  static Offset left = Offset(-1.0, 0.0);
  static Offset right = Offset(1.0, 0.0);
}
