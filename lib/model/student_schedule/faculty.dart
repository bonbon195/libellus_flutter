import 'group.dart';

class Faculty {
  String code;
  List<Group> groups;

  Faculty({required this.code, required this.groups});

  static List<Faculty> toTypedList(List<dynamic> list) =>
      list.map((e) => Faculty.fromDynamicMap(e)).toList();

  factory Faculty.fromDynamicMap(Map<String, dynamic> json) => Faculty(
      code: json["code"] ?? '',
      groups: json["groups"] == null
          ? List.empty()
          : Group.toTypedList(json["groups"]));
}
