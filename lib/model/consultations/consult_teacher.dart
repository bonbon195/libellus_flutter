import 'package:collection/collection.dart';

import 'consult_day.dart';

class ConsultTeacher implements Comparable<ConsultTeacher> {
  String name;
  List<ConsultDay> week;

  ConsultTeacher({required this.name, required this.week});

  static List<ConsultTeacher> toTypedList(List<dynamic> list) =>
      list.map((e) => ConsultTeacher.fromDynamicMap(e)).toList();

  factory ConsultTeacher.fromDynamicMap(Map<String, dynamic> json) =>
      ConsultTeacher(
          name: json["name"] ?? '',
          week: json.containsKey("week")
              ? json["week"] == null
                  ? List.empty()
                  : ConsultDay.toTypedList(json["week"])
              : List.empty());

  @override
  int compareTo(ConsultTeacher other) {
    return compareAsciiUpperCase(name, other.name);
  }
}
