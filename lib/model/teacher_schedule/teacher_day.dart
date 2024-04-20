import 'teacher_lesson.dart';

class TeacherDay {
  String date;
  List<TeacherLesson> lessons;

  TeacherDay({required this.date, required this.lessons});

  static List<TeacherDay> toTypedList(List<dynamic> list) =>
      list.map((e) => TeacherDay.fromDynamicMap(e)).toList();
  factory TeacherDay.fromDynamicMap(Map<String, dynamic> json) => TeacherDay(
      date: json["date"] ?? '',
      lessons: json["lessons"] == null
          ? List<TeacherLesson>.empty()
          : TeacherLesson.toTypedList(json["lessons"]));
}
