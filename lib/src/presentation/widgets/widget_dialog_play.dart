import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui;

class WidgetDialogPlay extends StatelessWidget {
  final bool isRightAnswers;
  final String message;
  final String btnText;
  final Function onTap;

  WidgetDialogPlay({
    Key key,
    this.onTap,
    this.message,
    this.btnText,
    @required this.isRightAnswers,
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
            WidgetDialogFace(isRightAnswers: isRightAnswers),
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

class WidgetDialogFace extends StatefulWidget {
  final bool isRightAnswers;

  const WidgetDialogFace({Key key, this.isRightAnswers}) : super(key: key);

  @override
  _WidgetDialogFaceState createState() => _WidgetDialogFaceState();
}

class _WidgetDialogFaceState extends State<WidgetDialogFace> {
  bool isDone;
  Node _nodeHand;
  Node _nodeBackground;
  Node _nodeForeground;
  ImageMap images;
  Size bgSize;

  @override
  void initState() {
    bgSize = Size(140, 140);
    isDone = false;
    _nodeHand = NodeWithSize(Size(140, 140));
    _nodeBackground = NodeWithSize(bgSize);
    _nodeForeground = NodeWithSize(bgSize);
    AssetBundle bundle = rootBundle;
    images = new ImageMap(bundle);
    if (widget.isRightAnswers) {
      _rightAnswerAnimation(bundle).then((_) {
        setState(() {
          isDone = true;
        });
      });
    } else {
      _wrongAnswerAnimation(bundle).then((_) {
        setState(() {
          isDone = true;
        });
      });
    }

    super.initState();
  }

  Future _rightAnswerAnimation(AssetBundle bundle) async {
    await _loadAssets(bundle);
    final rightHand = new Sprite.fromImage(images['assets/images/hand.png']);
    final bg = new Sprite.fromImage(images['assets/images/bg_star_white.png']);
    _nodeHand.addChild(rightHand);
    _nodeBackground.addChild(bg);
    _nodeForeground
        .addChild(Sprite.fromImage(images['assets/images/bg_star_yellow.png']));
    final handTween =
        MotionTween<double>((a) => rightHand.scale = a, 1, 0.8, 1);
    final bgTween = MotionTween<double>((a) => bg.opacity = a, 0, 1, 0.6);
    _nodeHand.motions.run(MotionRepeatForever(handTween));
    _nodeBackground.motions.run(MotionRepeatForever(bgTween));
  }

  Future _wrongAnswerAnimation(AssetBundle bundle) async {
    await _loadAssets(bundle);
    final _wrongHand = new Sprite.fromImage(images['assets/images/hand2.png']);
    _nodeHand.addChild(_wrongHand);
    final myTween = new MotionTween<Offset>(
      (a) => _wrongHand.position = a,
      Offset(0, 0),
      Offset(30, 30),
      1,
    );
    final longLoop = new MotionRepeatForever(myTween);
    _nodeHand.motions.run(longLoop);
  }

  Future _loadAssets(AssetBundle bundle) async {
    await images.load(<String>[
      'assets/images/hand.png',
      'assets/images/hand2.png',
      'assets/images/bg_star_white.png',
      'assets/images/bg_star_yellow.png',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return isDone
        ? Stack(
            children: [
              widget.isRightAnswers
                  ? Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                              top: 180,
                              child: Container(
                                width: bgSize.width - 40,
                                height: bgSize.height - 40,
                                child: SpriteWidget(_nodeForeground,
                                    SpriteBoxTransformMode.fixedWidth),
                              )),
                          Positioned(
                            top: 180,
                            child: SizedBox(
                                width: bgSize.width - 40,
                                height: bgSize.height - 40,
                                child: SpriteWidget(_nodeBackground,
                                    SpriteBoxTransformMode.fixedWidth)),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    widget.isRightAnswers
                        ? 'assets/images/face.png'
                        : 'assets/images/face_sad.png',
                    width: 220,
                    height: 220,
                  )),
              Positioned(
                top: 130,
                left: 90,
                child: Container(
                  height: 80,
                  width: 80,
                  child: SpriteWidget(_nodeHand),
                ),
              ),
            ],
          )
        : Container();
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
