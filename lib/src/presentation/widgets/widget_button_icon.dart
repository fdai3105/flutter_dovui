import 'package:flutter/material.dart';

class WidgetHomeIcon extends StatelessWidget {
  final Function onTap;
  final String image;
  final String icon;

  const WidgetHomeIcon({
    Key key,
    this.onTap,
    this.image,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ImageIcon(
            AssetImage(icon),
            size: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
