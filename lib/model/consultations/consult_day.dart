class ConsultDay {
  String name;
  String date;
  String time;
  String classroom;

  ConsultDay(
      {required this.name,
      required this.date,
      required this.time,
      required this.classroom});

  static List<ConsultDay> toTypedList(List<dynamic> list) =>
      list.map((e) => ConsultDay.fromDynamicMap(e)).toList();

  factory ConsultDay.fromDynamicMap(Map<String, dynamic> json) => ConsultDay(
        name: json.containsKey("name") ? json["name"] ?? '' : '',
        date: json.containsKey("date") ? json["date"] ?? '' : '',
        classroom: json.containsKey("classroom") ? json["classroom"] ?? '' : '',
        time: json.containsKey("time") ? json["time"] ?? '' : '',
      );
}
