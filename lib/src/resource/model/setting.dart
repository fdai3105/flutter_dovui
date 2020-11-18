class Setting {
  final bool music;
  final int level;
  final int life;

  Setting({this.music, this.level, this.life});

  Setting copyWith({bool music, int level, int life}) {
    return Setting(
      music: music ?? this.music,
      level: level ?? this.level,
      life: life ?? this.life,
    );
  }

  @override
  String toString() {
    return 'Setting{music: $music, point: $level, life: $life}';
  }
}
