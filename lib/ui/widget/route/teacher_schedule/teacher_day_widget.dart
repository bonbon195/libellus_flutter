import 'package:flutter/material.dart';
import 'package:libellus/model/teacher_schedule/teacher_lesson.dart';

import 'teacher_lesson_widget.dart';

class TeacherDayWidget extends StatefulWidget {
  final String date;
  final List<TeacherLesson> teacherLessons;
  const TeacherDayWidget(
      {super.key, required this.date, required this.teacherLessons});

  @override
  State<TeacherDayWidget> createState() => _TeacherDayWidgetState();
}

class _TeacherDayWidgetState extends State<TeacherDayWidget> {
  List<TeacherLessonWidget> lessonWidgets = List.empty();

  @override
  void initState() {
    _loadTeacherLessons(widget.teacherLessons);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Text(date);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(widget.date),
      Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
              itemCount: lessonWidgets.length,
              itemBuilder: (context, index) {
                return lessonWidgets[index];
              }))
    ]);
  }

  List<TeacherLessonWidget> _loadTeacherLessons(List<TeacherLesson> lessons) {
    List<TeacherLessonWidget> widgets = List.empty(growable: true);
    for (var lesson in lessons) {
      widgets.add(TeacherLessonWidget(teacherLesson: lesson));
    }
    return widgets;
  }
}
