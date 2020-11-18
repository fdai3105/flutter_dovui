import 'package:hues_dovui/src/config/app_prefs.dart';
import 'package:hues_dovui/src/resource/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences _pref;

  static Future instance() async {
    _pref = await SharedPreferences.getInstance();

    if (getSetting().music == null ||
        getSetting().life == null ||
        getSetting().level == null) {
      SharedPref().saveSetting(Setting(music: true, life: 5, level: 1));
    }
  }

  void saveSetting(Setting setting) async {
    await _pref.setBool(AppPrefs.MUSIC, setting.music);
    await _pref.setInt(AppPrefs.LEVEL, setting.level);
    await _pref.setInt(AppPrefs.LIFE, setting.life);
  }

  static Setting getSetting() {
    return Setting(
      music: _pref.getBool(AppPrefs.MUSIC),
      level: _pref.getInt(AppPrefs.LEVEL),
      life: _pref.getInt(AppPrefs.LIFE),
    );
  }
}
