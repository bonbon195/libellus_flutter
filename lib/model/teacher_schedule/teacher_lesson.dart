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
        name: json.containsKey("name") ? json["name"] ?? '' : '',
        group: json.containsKey("group") ? json["group"] ?? '' : '',
        classroom: json.containsKey("classroom") ? json["classroom"] ?? '' : '',
        time: json.containsKey("time") ? json["time"] ?? '' : '',
        subgroup: json.containsKey("subgroup") ? json["subgroup"] ?? 0 : 0,
        height: json.containsKey("height") ? json["height"] ?? 1 : 1,
      );
}
