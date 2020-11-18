import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/base/base.dart';
import 'package:hues_dovui/src/presentation/home/home_viewmodel.dart';
import 'package:hues_dovui/src/presentation/play/play.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_button_home.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_button_icon.dart';
import 'package:hues_dovui/src/routers.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_home.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: BaseWidget<HomeViewModel>(
            viewModel: HomeViewModel(),
            onViewModelReady: (viewModel) {
              viewModel.setLoading(true);
              viewModel.init();
              viewModel.setLoading(false);
            },
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetHomeIcons(),
                    SizedBox(
                      height: 360,
                    ),
                    // TODO:
                    // WidgetTextLevel(),
                    Column(
                      children: [
                        WidgetHomeButton(
                          onTap: () =>
                              Navigator.pushNamed(context, Routers.play),
                          text: "Vào chơi",
                          isPrimary: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        WidgetHomeButton(
                          onTap: () =>
                              Navigator.pushNamed(context, Routers.moreGame),
                          text: "Game hot",
                          isPrimary: false,
                        )
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class WidgetHomeIcons extends StatelessWidget {
  const WidgetHomeIcons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        WidgetHomeIcon(
          onTap: () {
            Share.share(
                'Chơi cái này zui lắm nè\nhttps://play.google.com/store/apps/details?id=com.huesoft.dovuihainao');
          },
          homeIcon: HomeIcon.Share,
        ),
        WidgetHomeIcon(
          onTap: () {
            LaunchReview.launch(androidAppId: "com.huesoft.dovuihainao");
          },
          homeIcon: HomeIcon.Like,
        ),
        WidgetHomeIcon(
          onTap: () {
            final _homeProvider =
                Provider.of<HomeViewModel>(context, listen: false);
            _homeProvider.setSetting(_homeProvider.setting
                .copyWith(music: _homeProvider.setting.music ? false : true));
          },
          homeIcon: HomeIcon.Sound,
        ),
      ],
    );
  }
}

class WidgetTextLevel extends StatelessWidget {
  const WidgetTextLevel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<PlayViewModel>(context).getTest.listen((event) {
      print(event.toString());
    });
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Text(
        'Cấp độ 0',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
