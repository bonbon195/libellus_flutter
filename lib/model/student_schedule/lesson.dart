class Lesson {
  String name;
  String teacher;
  String classroom;
  String time;
  int subgroup;
  int height;

  Lesson(
      {required this.name,
      required this.teacher,
      required this.classroom,
      required this.time,
      required this.subgroup,
      required this.height});

  static List<Lesson> toTypedList(List<dynamic> list) =>
      list.map((e) => Lesson.fromDynamicMap(e)).toList();

  factory Lesson.fromDynamicMap(Map<String, dynamic> json) => Lesson(
        name: json["name"] ?? '',
        teacher: json["teacher"] ?? '',
        classroom: json["classroom"] ?? '',
        time: json["time"] ?? '',
        subgroup: json["subgroup"] ?? 0,
        height: json["height"] ?? 1,
      );
}
