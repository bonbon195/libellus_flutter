class TeacherLesson {
  String name;
  String group;
  String classroom;
  String time;
  int subgroup;
  int height;

  TeacherLesson(
      {required this.name,
      required this.group,
      required this.classroom,
      required this.time,
      required this.subgroup,
      required this.height});

  static List<TeacherLesson> toTypedList(List<dynamic> list) =>
      list.map((e) => TeacherLesson.fromDynamicMap(e)).toList();
  factory TeacherLesson.fromDynamicMap(Map<String, dynamic> json) =>
      TeacherLesson(
        name: json["name"] ?? '',
        group: json["group"] ?? '',
        classroom: json["classroom"] ?? '',
        time: json["time"] ?? '',
        subgroup: json["subgroup"] ?? 0,
        height: json["height"] ?? 1,
      );
}
