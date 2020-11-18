import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

enum HomeIcon {
  Share,
  Like,
  Sound,
}

class WidgetHomeIcon extends StatelessWidget {
  final Function onTap;
  final HomeIcon homeIcon;

  const WidgetHomeIcon({
    Key key,
    this.onTap,
    this.homeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _iconImage(context),
      onPressed: onTap,
      iconSize: 50,
    );
  }

  Widget _iconImage(BuildContext context) {
    switch (homeIcon) {
      case HomeIcon.Share:
        return Image.asset(
          'assets/images/btn_share.png',
        );
        break;
      case HomeIcon.Like:
        return Image.asset(
          'assets/images/btn_like.png',
        );
        break;
      case HomeIcon.Sound:
        final _soundOn = Provider.of<HomeViewModel>(context).setting.music;
        return _soundOn
            ? Image.asset(
                'assets/images/btn_sound_on.png',
                gaplessPlayback: false,
              )
            : Image.asset(
                'assets/images/btn_sound_off.png',
                gaplessPlayback: false,
              );
        break;
      default:
        return null;
        break;
    }
  }
}
