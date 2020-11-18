import 'dart:convert';

class Question {
  int id;
  String cauHoi;
  String a;
  String b;
  String c;
  String d;
  String dapan;
  String giaiThich;
  String isvisible;
  String uid;
  DateTime qtime;
  String level;

  Question({
    this.id,
    this.cauHoi,
    this.a,
    this.b,
    this.c,
    this.d,
    this.dapan,
    this.giaiThich,
    this.isvisible,
    this.uid,
    this.qtime,
    this.level,
  });

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: int.parse(json["ID"]),
        cauHoi: json["CauHoi"],
        a: json["A"],
        b: json["B"],
        c: json["C"],
        d: json["D"],
        dapan: json["A"],
        giaiThich: json["GiaiThich"],
        isvisible: json["isvisible"],
        uid: json["uid"],
        qtime: DateTime.parse(json["qtime"]),
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CauHoi": cauHoi,
        "A": a,
        "B": b,
        "C": c,
        "D": d,
        "GiaiThich": giaiThich,
        "isvisible": isvisible,
        "uid": uid,
        "qtime":
            "${qtime.year.toString().padLeft(4, '0')}-${qtime.month.toString().padLeft(2, '0')}-${qtime.day.toString().padLeft(2, '0')}",
        "level": level,
      };

  @override
  String toString() {
    return 'Question{id: $id, cauHoi: $cauHoi, a: $a, b: $b, c: $c, d: $d, giaiThich: $giaiThich, isvisible: $isvisible, uid: $uid, qtime: $qtime, level: $level}';
  }
}
