import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/base/base_viewmodel.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_dialog_play.dart';
import 'package:hues_dovui/src/resource/model/setting.dart';
import 'package:hues_dovui/src/resource/service/SoundService.dart';
import 'package:hues_dovui/src/utlis/shared_pref.dart';
import 'package:rxdart/subjects.dart';

class HomeViewModel extends BaseViewModel {
  final _setting = BehaviorSubject<Setting>();
  final _pref = SharedPref();

  Future init() async {
    _setting.add(SharedPref.getSetting());
    _playMusic();
  }

  setSetting(Setting setting) {
    if (setting.music != SharedPref.getSetting().music) {
      _pref.saveSetting(setting);
      _setting.add(SharedPref.getSetting());
      _playMusic();
      notifyListeners();
    }
  }

  Setting get setting => _setting.value;

  void _playMusic() async {
    if (_setting.value.music) {
      await SoundService().unMute();
    } else {
      await SoundService().mute();
    }
  }
}
