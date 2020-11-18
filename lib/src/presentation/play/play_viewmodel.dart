import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hues_dovui/src/config/app_endpoint.dart';
import 'package:hues_dovui/src/presentation/base/base_viewmodel.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_dialog_play.dart';
import 'package:hues_dovui/src/resource/model/question.dart';
import 'package:hues_dovui/src/resource/model/setting.dart';
import 'package:hues_dovui/src/resource/repository/question_repository.dart';
import 'package:hues_dovui/src/resource/service/SoundService.dart';
import 'package:hues_dovui/src/utlis/shared_pref.dart';
import 'package:rxdart/subjects.dart';

class PlayViewModel extends BaseViewModel {
  var _questions = <Question>[];
  final _setting = SharedPref();
  var _cursor = 0;

  final _life = BehaviorSubject<int>();
  final _level = BehaviorSubject<int>();
  final _question = BehaviorSubject<Question>();
  final _randomAnswers = BehaviorSubject<List<String>>();
  final _levelTest = BehaviorSubject<int>();

  Future<void> init() async {
    setLife(SharedPref.getSetting().life);
    setLevel(SharedPref.getSetting().level);
    _questions = await QuestionRepository().getQuestions(getLevel);
    setQuestion(_cursor);
    setAnswers(getQuestion);
    _levelTest.add(getLevel);
  }

  /// getter & setter
  int get getLife => _life.value;

  void setLife(int life) {
    if (life >= 0) {
      this._life.add(life);
      _setting.saveSetting(SharedPref.getSetting().copyWith(life: life));
      notifyListeners();
    }
  }

  int get getLevel => _level.value;

  void setLevel(int level) {
    this._level.add(level);
    _setting.saveSetting(SharedPref.getSetting().copyWith(level: level));
    notifyListeners();
  }

  Question get getQuestion => _question.value;

  void setQuestion(int level) {
    _questions.shuffle();
    _question.add(_questions[_cursor]);
    notifyListeners();
  }

  List<String> get getAnswers => _randomAnswers.value;

  void setAnswers(Question question) {
    _randomAnswers
        .add([question.a, question.b, question.c, question.d]..shuffle());
    notifyListeners();
  }

  void setTest(int test) {
    _levelTest.add(test);
    notifyListeners();
  }

  Stream get getTest => _levelTest.stream;

  /// voids
  void answer(String answer) async {
    if (answer == getQuestion.dapan) {
      if (_questions.length == getLevel) {
        if (getLevel == AppEndpoint.MAX_QUESTION) {
          print('pha dao');
          _dialogPhaDao();
          return;
        }
      } else {
        _questions += await QuestionRepository().getQuestions(getLevel);
      }
      _dialogRight();
      await SoundService().playSound(GameSound.Right);
    } else {
      setLife(getLife - 1);
      if (getLife == 0) {
        await SoundService().playSound(GameSound.Loss);
        _dialogLose();
      } else {
        await SoundService().playSound(GameSound.Wrong);
        _questions.removeWhere((element) => element.id == getQuestion.id);
        _dialogWrong();
      }
    }
  }

  void _reset() {
    setLife(5);
    setLevel(1);
    _setting.saveSetting(SharedPref.getSetting().copyWith(life: 5, level: 1));
    _questions.shuffle();
    setQuestion(getLevel);
    setAnswers(getQuestion);
  }

  void _dialogRight() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) {
        return WidgetDialogPlay(
          isRightAnswers: true,
          btnText: 'Câu tiếp',
          message: getQuestion.giaiThich ?? "Giỏi thế ^^",
          onTap: () {
            _cursor++;
            setLevel(getLevel + 1);
            setQuestion(getLevel);
            setAnswers(getQuestion);
            setTest(getLevel + 1);
          },
        );
      },
    );
  }

  void _dialogWrong() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) {
        return WidgetDialogPlay(
          isRightAnswers: false,
          message: getQuestion.giaiThich,
          btnText: "Chơi lại",
          onTap: () {
            setQuestion(getLevel);
            setAnswers(getQuestion);
          },
        );
      },
    );
  }

  void _dialogLose() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) {
        return WidgetDialogPlay(
          btnText: 'Chơi lại',
          message: 'Hết mạng quay lại level 1 nhé ^^',
          isRightAnswers: false,
          onTap: () {
            _reset();
          },
        );
      },
    );
  }

  void _dialogPhaDao() {}

  @override
  void dispose() async {
    await _life.drain();
    _life.close();
    await _level.drain();
    _level.close();
    await _question.drain();
    _question.close();
    await _randomAnswers.drain();
    _randomAnswers.close();
    super.dispose();
  }
}
