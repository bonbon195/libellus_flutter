import 'package:flutter/material.dart';
import 'package:libellus/model/teacher_schedule/teacher_lesson.dart';

class TeacherLessonWidget extends StatelessWidget {
  final TeacherLesson teacherLesson;
  const TeacherLessonWidget({super.key, required this.teacherLesson});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100 * teacherLesson.height.toDouble(),
        child: Column(
          children: [
            Expanded(
                child: SizedBox.fromSize(
                    size: const Size.fromWidth(400),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                teacherLesson.name.replaceAll("\n", ""),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      teacherLesson.group.replaceAll("\n", "")),
                                  Text(
                                      " ${teacherLesson.classroom.replaceAll("\n", "")}"),
                                ],
                              ),
                              Text(
                                teacherLesson.time.replaceAll("\n", ""),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      ),
                    ))),
            const Divider(
              height: 4,
              color: Colors.transparent,
            )
          ],
        ));
  }
}
