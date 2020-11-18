import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hues_dovui/src/utlis/shared_pref.dart';

enum GameSound {
  Wrong,
  Right,
  Loss,
  Music,
  MoreApp,
  Back,
}

class SoundService {
  static AudioPlayer _fixerAudio;
  static AudioCache _player;
  static AudioPlayer _bgFixer;
  static AudioCache _bgPlayer;

  static init() {
    _fixerAudio = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    _player = AudioCache(fixedPlayer: _fixerAudio);

    _bgFixer = AudioPlayer(
        mode: PlayerMode.MEDIA_PLAYER, playerId: 'background_music');
    _bgPlayer = AudioCache(fixedPlayer: _bgFixer);
    _bgFixer.setReleaseMode(ReleaseMode.LOOP);
  }

  Future<void> playSound(GameSound name) async {
    if (SharedPref.getSetting().music) {
      switch (name) {
        case GameSound.Right:
          await _player.play('sounds/victory.wav');
          break;
        case GameSound.Wrong:
          await _player.play('sounds/fail.wav');
          break;
        case GameSound.Loss:
          await _player.play('sounds/fail.wav');
          break;
        case GameSound.MoreApp:
          await _player.play('sounds/moreapp.wav');
          break;
        case GameSound.Music:
          await _bgPlayer.play('sounds/music_bg.mp3');
          break;
        case GameSound.Back:
          await _player.play('sounds/back.wav');
          break;
      }
    }
  }

  Future<void> mute() async {
    await _fixerAudio.setVolume(0);
    await _bgFixer.setVolume(0);
  }

  Future<void> unMute() async {
    await _fixerAudio.setVolume(1);
    await _bgFixer.setVolume(0.5);
  }
}
