import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:libellus/model/consultations/consult_teacher.dart';
import 'package:libellus/model/student_schedule/faculty.dart';
import 'package:libellus/model/student_schedule/group.dart';
import 'package:libellus/model/teacher_schedule/teacher.dart';

const String _serverUrl = String.fromEnvironment('API_URL');

final _client = http.Client();

Future<List<Faculty>> getAllStudentSchedule() async {
  var scheduleJson = await _getStudentScheduleJson();
  var schedule = Faculty.toTypedList(jsonDecode(scheduleJson));
  return schedule;
}

Future<Faculty> getFacultyStudentSchedule(String faculty) async {
  var scheduleJson = await _getStudentScheduleJson(faculty);
  var schedule = Faculty.fromDynamicMap(jsonDecode(scheduleJson));
  return schedule;
}

Future<Group> getGroupStudentSchedule(String faculty, String group) async {
  var scheduleJson = await _getStudentScheduleJson(faculty, group);
  var schedule = Group.fromDynamicMap(jsonDecode(scheduleJson));
  return schedule;
}

Future<String> _getStudentScheduleJson([String? faculty, String? group]) async {
  var uri = Uri.https(
      _serverUrl, '/getStudentSchedule', {'faculty': faculty, 'group': group});
  try {
    var response = await _client.get(uri);
    return utf8.decode(response.bodyBytes);
  } catch (exception) {
    return "";
  }
}

Future<List<Teacher>> getAllTeacherSchedule() async {
  var scheduleJson = await _getTeacherScheduleJson();
  var schedule = Teacher.toTypedList(jsonDecode(scheduleJson));
  schedule.sort();
  return schedule;
}

Future<Teacher> getTeacherSchedule(String teacher) async {
  var scheduleJson = await _getTeacherScheduleJson(teacher);
  var schedule = Teacher.fromDynamicMap(jsonDecode(scheduleJson));
  return schedule;
}

Future<String> _getTeacherScheduleJson([String? teacher]) async {
  var uri = Uri.https(_serverUrl, '/getTeacherSchedule', {
    'teacher': teacher,
  });
  try {
    var response = await _client.get(uri);
    return utf8.decode(response.bodyBytes);
  } catch (exception) {
    return "";
  }
}

Future<Map<String, List<ConsultTeacher>>> getAllTeacherConsultations() async {
  var scheduleJson = await _getTeacherConsultationsJson();
  Map<dynamic, dynamic> jsonMap = jsonDecode(scheduleJson).map((k, v) {
    var list = ConsultTeacher.toTypedList(v);
    list.sort();
    return MapEntry(k, list);
  });
  Map<String, List<ConsultTeacher>> consultations = Map.from(jsonMap);
  return consultations;
}

Future<List<ConsultTeacher>> getWeekTeacherConsultations(String week) async {
  var scheduleJson = await _getTeacherConsultationsJson(week);
  var consultations = ConsultTeacher.toTypedList(jsonDecode(scheduleJson));
  return consultations;
}

Future<ConsultTeacher> getTeacherConsultations(
    String week, String teacher) async {
  var scheduleJson = await _getTeacherConsultationsJson(week, teacher);
  var consultations = ConsultTeacher.fromDynamicMap(jsonDecode(scheduleJson));
  return consultations;
}

Future<String> _getTeacherConsultationsJson(
    [String? week, String? teacher]) async {
  var uri = Uri.https(_serverUrl, '/getTeacherConsultations', {
    'week': week,
    'teacher': teacher,
  });
  try {
    var response = await _client.get(uri);
    return utf8.decode(response.bodyBytes);
  } catch (exception) {
    return "";
  }
}

Future<String> getUpdateDate() async {
  return await _getUpdateDateJson();
}

Future<String> _getUpdateDateJson() async {
  var uri = Uri.https(_serverUrl, '/getUpdateDate');
  try {
    var response = await _client.get(uri);
    return utf8.decode(response.bodyBytes);
  } catch (exception) {
    return "";
  }
}
