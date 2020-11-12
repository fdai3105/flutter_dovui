import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/more_app/more_app_screen.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_button_home.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_button_icon.dart';
import 'package:hues_dovui/src/routers.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_home.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                WidgetHomeIcon(
                  onTap: () {
                    Share.share(
                        'Chơi cái này zui lắm nè\nhttps://play.google.com/store/apps/details?id=com.huesoft.dovuihainao');
                  },
                  image: 'assets/images/btn_home_blue.png',
                  icon: 'assets/images/icon_share.png',
                ),
                SizedBox(
                  width: 10,
                ),
                WidgetHomeIcon(
                  onTap: () {
                    LaunchReview.launch(
                        androidAppId: "com.huesoft.dovuihainao");
                  },
                  image: 'assets/images/btn_home_red.png',
                  icon: 'assets/images/icon_like.png',
                ),
                SizedBox(
                  width: 10,
                ),
                WidgetHomeIcon(
                  onTap: () {},
                  image: 'assets/images/btn_home_green.png',
                  icon: 'assets/images/icon_sound.png',
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              height: 350,
            ),
            Column(
              children: [
                WidgetHomeButton(
                  onTap: () => Navigator.pushNamed(context, Routers.play),
                  text: "Vào chơi",
                  isPrimary: true,
                ),
                SizedBox(
                  height: 20,
                ),
                WidgetHomeButton(
                  onTap: () => Navigator.pushNamed(context, Routers.moreGame),
                  text: "Game hot",
                  isPrimary: false,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
