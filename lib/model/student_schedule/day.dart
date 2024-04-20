import 'lesson.dart';

class Day {
  String name;
  String date;
  List<Lesson> lessons;

  Day({required this.name, required this.date, required this.lessons});

  static List<Day> toTypedList(List<dynamic> list) =>
      list.map((e) => Day.fromDynamicMap(e)).toList();

  factory Day.fromDynamicMap(Map<String, dynamic> json) => Day(
      name: json["name"] ?? '',
      date: json["date"] ?? '',
      lessons: json["lessons"] == null
          ? List<Lesson>.empty()
          : Lesson.toTypedList(json["lessons"]));
}
