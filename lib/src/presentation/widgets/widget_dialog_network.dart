import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui;

class WidgetDialogNetwork extends StatelessWidget {
  final String message;
  final String btnText;
  final Function onTap;

  WidgetDialogNetwork({
    Key key,
    this.onTap,
    this.message,
    this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            // background image
            Image.asset('assets/images/bg_dialog.png'),
            // body text
            Positioned(
              top: 335,
              left: 0,
              right: 0,
              child: Container(
                height: 160,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      message ?? 'null',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // button
            WidgetDialogButton(onTap: onTap, btnText: btnText),
          ],
        ),
      ),
    );
  }
}

class WidgetDialogButton extends StatefulWidget {
  final Function onTap;
  final String btnText;

  const WidgetDialogButton({Key key, this.onTap, this.btnText})
      : super(key: key);

  @override
  _WidgetDialogButtonState createState() => _WidgetDialogButtonState();
}

class _WidgetDialogButtonState extends State<WidgetDialogButton> {
  bool _isPress;
  AssetImage _btn;
  ImageProvider _btnPress;

  @override
  void initState() {
    _isPress = false;
    _btn = AssetImage('assets/images/btn_play_again.png');
    _btnPress = AssetImage('assets/images/btn_play_again_press.png');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(_btn, context);
    precacheImage(_btnPress, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 260,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          Navigator.pop(context);
        },
        onTapUp: (_) => _onPress(false),
        onTapDown: (_) => _onPress(true),
        onTapCancel: () => _onPress(false),
        child: Container(
          height: 80,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _isPress ? _btnPress : _btn,
            ),
          ),
          child: Center(
              child: Text(
            widget.btnText ?? 'null',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
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
