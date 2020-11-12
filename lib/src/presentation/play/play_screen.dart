import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_play.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            WidgetPlayHeader(),
            SizedBox(
              height: 10,
            ),
            WidgetPlayQuestion(),
          ],
        ),
      ),
    );
  }
}

class WidgetPlayQuestion extends StatelessWidget {
  const WidgetPlayQuestion({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 250,
      padding: EdgeInsets.fromLTRB(40, 0, 40, 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_play_table.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "CẤP ĐỘ 1",
            style: TextStyle(
              color: Colors.yellowAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 125,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Text(
                "data data data data data data data data data data data data data data data data data data data data data data data data data data data data data data data data ",
                style: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WidgetPlayHeader extends StatelessWidget {
  const WidgetPlayHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg_play_header.png',
          fit: BoxFit.fitWidth,
        ),
        Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ic_heart.png',
                  fit: BoxFit.fill,
                  width: 36,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            )),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: Image.asset('assets/images/btn_back.png'),
            iconSize: 50,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Image.asset('assets/images/btn_share.png'),
            iconSize: 50,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
