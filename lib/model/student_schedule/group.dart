import 'day.dart';

class Group {
  String name;
  List<Day> days;

  Group({required this.name, required this.days});

  static List<Group> toTypedList(List<dynamic> list) =>
      list.map((e) => Group.fromDynamicMap(e)).toList();

  factory Group.fromDynamicMap(Map<String, dynamic> json) => Group(
      name: json.containsKey("name") ? json["name"] ?? '' : '',
      days: json.containsKey("days")
          ? json["days"] == null
              ? List.empty()
              : Day.toTypedList(json["days"])
          : List.empty());
}
