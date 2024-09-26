import 'teacher_day.dart';
import "package:collection/collection.dart";

class Teacher implements Comparable<Teacher> {
  String name;
  List<TeacherDay> week;

  Teacher({required this.name, required this.week});

  static List<Teacher> toTypedList(List<dynamic> list) =>
      list.map((e) => Teacher.fromDynamicMap(e)).toList();

  factory Teacher.fromDynamicMap(Map<String, dynamic> json) => Teacher(
      name: json["name"] ?? '',
      week: json.containsKey("week")
          ? json["week"] == null
              ? List.empty()
              : TeacherDay.toTypedList(json["week"])
          : List.empty());

  @override
  int compareTo(Teacher other) {
    return compareAsciiUpperCase(name, other.name);
  }
}
