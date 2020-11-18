import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hues_dovui/src/presentation/base/base_widget.dart';
import 'package:hues_dovui/src/presentation/play/play.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_button_answer.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';

class PlayScreen extends StatelessWidget {
  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_play.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: BaseWidget<PlayViewModel>(
              viewModel: PlayViewModel(),
              onViewModelReady: (viewModel) async {
                viewModel.setLoading(true);
                await viewModel.init();
                viewModel.setLoading(false);
              },
              builder: (context, viewModel, child) {
                if (!viewModel.isLoading) {
                  return Column(
                    children: [
                      WidgetPlayHeader(
                        life: viewModel.getLife,
                        onShare: () async {
                          final directory =
                              (await getApplicationDocumentsDirectory()).path;
                          final time = DateTime.now().millisecondsSinceEpoch;
                          final path =
                              '$directory/screenshot_dovuihainao_$time.png';
                          screenshotController
                              .capture(path: path)
                              .then((image) async {
                            await ImageGallerySaver.saveImage(
                                image.readAsBytesSync());
                            ShareExtend.share(image.path, 'image');
                            // await FlutterShare.shareFile(
                            //     title: 'Help me',
                            //     filePath:
                            //         '/data/data/com.phidai.hues_dovui/app_flutter/screenshot_dovuihainao_1605683561889.png');
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WidgetQuestion(
                        level: viewModel.getLevel,
                        question: viewModel.getQuestion.cauHoi,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      WidgetAnswers(
                        question: viewModel.getAnswers,
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              child: Container(),
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetPlayHeader extends StatelessWidget {
  final Function onShare;
  final int life;

  WidgetPlayHeader({
    Key key,
    @required this.life,
    this.onShare,
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
            top: 18,
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
                  life.toString() ?? "0",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            )),
        // back button
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: Image.asset('assets/images/btn_back.png'),
            iconSize: 40,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        // share button
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Image.asset('assets/images/btn_share.png'),
            iconSize: 40,
            onPressed: onShare,
          ),
        ),
      ],
    );
  }
}

class WidgetQuestion extends StatelessWidget {
  final int level;
  final String question;

  WidgetQuestion({
    Key key,
    @required this.level,
    @required this.question,
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
            "CẤP ĐỘ $level",
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
                question ?? "null",
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

class WidgetAnswers extends StatelessWidget {
  final List<String> question;

  const WidgetAnswers({this.question});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 0,
      children: [
        WidgetButtonAnswer(
          type: QuestionType.QuestionA,
          question: question[0],
        ),
        WidgetButtonAnswer(
          type: QuestionType.QuestionB,
          question: question[1],
        ),
        WidgetButtonAnswer(
          type: QuestionType.QuestionC,
          question: question[2],
        ),
        WidgetButtonAnswer(
          type: QuestionType.QuestionD,
          question: question[3],
        ),
      ],
    );
  }
}
