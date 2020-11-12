import 'package:flutter/material.dart';

class WidgetHomeButton extends StatefulWidget {
  final bool isPrimary;
  final Function onTap;
  final String text;

  const WidgetHomeButton({Key key, this.isPrimary, this.onTap, this.text})
      : super(key: key);

  @override
  _WidgetHomeButtonState createState() => _WidgetHomeButtonState();
}

class _WidgetHomeButtonState extends State<WidgetHomeButton> {
  bool _isPress;

  @override
  void initState() {
    _isPress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapUp: (_) => _onPress(false),
      onTapDown: (_) => _onPress(true),
      onTapCancel: () => _onPress(false),
      onHorizontalDragEnd: (_) => _onPress(false),
      onVerticalDragEnd: (_) => _onPress(false),
      child: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: _isPress
                  ? AssetImage(widget.isPrimary
                      ? 'assets/images/btn_home_play_press.png'
                      : 'assets/images/btn_home_more_press.png')
                  : AssetImage(widget.isPrimary
                      ? 'assets/images/btn_home_play.png'
                      : 'assets/images/btn_home_more.png'),
              fit: BoxFit.fill),
        ),
        child: Center(
            child: Text(
          widget.text ?? "empty",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }

  void _onPress(bool value) {
    if (_isPress != value) {
      setState(() {
        _isPress = value;
      });
    }
  }
}
