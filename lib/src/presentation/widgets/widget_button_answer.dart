import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/play/play.dart';
import 'package:provider/provider.dart';

enum QuestionType { QuestionA, QuestionB, QuestionC, QuestionD }

class WidgetButtonAnswer extends StatefulWidget {
  final QuestionType type;
  final String question;

  const WidgetButtonAnswer({Key key, this.type, this.question})
      : super(key: key);

  @override
  _WidgetButtonAnswerState createState() => _WidgetButtonAnswerState();
}

class _WidgetButtonAnswerState extends State<WidgetButtonAnswer> {
  bool _isPress;

  @override
  void initState() {
    _isPress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PlayViewModel>(context, listen: false)
            .answer(widget.question);
      },
      onTapUp: (_) => _onPress(false),
      onTapDown: (_) => _onPress(true),
      onTapCancel: () => _onPress(false),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset(_isPress
                      ? 'assets/images/btn_asn_press.png'
                      : 'assets/images/btn_asn.png',gaplessPlayback: true,),
                ),
                _head(widget.type),
                Positioned(
                  left: 90,
                  child: Text(
                    widget.question ?? "null",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _head(QuestionType question) {
    switch (question) {
      case QuestionType.QuestionA:
        return Image.asset(
          'assets/images/btn_head_a.png',
          width: 80,
        );
        break;
      case QuestionType.QuestionB:
        return Image.asset(
          'assets/images/btn_head_b.png',
          width: 80,
        );
        break;
      case QuestionType.QuestionC:
        return Image.asset(
          'assets/images/btn_head_c.png',
          width: 80,
        );
        break;
      case QuestionType.QuestionD:
        return Image.asset(
          'assets/images/btn_head_d.png',
          width: 80,
        );
        break;
      default:
        return Image.asset(
          'assets/images/btn_head_a.png',
          width: 80,
        );
    }
  }

  void _onPress(bool value) {
    if (_isPress != value) {
      setState(() {
        _isPress = value;
      });
    }
  }
}
