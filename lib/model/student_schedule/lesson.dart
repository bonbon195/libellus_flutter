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
        name: json.containsKey("name") ? json["name"] ?? '' : '',
        teacher: json.containsKey("teacher") ? json["teacher"] ?? '' : '',
        classroom: json.containsKey("classroom") ? json["classroom"] ?? '' : '',
        time: json.containsKey("time") ? json["time"] ?? '' : '',
        subgroup: json.containsKey("subgroup") ? json["subgroup"] ?? 0 : 0,
        height: json.containsKey("height") ? json["height"] ?? 1 : 1,
      );
}
