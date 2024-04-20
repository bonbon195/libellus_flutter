import 'package:flutter/material.dart';
import 'package:libellus/model/student_schedule/lesson.dart';

class LessonWidget extends StatelessWidget {
  final Lesson lesson;
  const LessonWidget({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100 * lesson.height.toDouble(),
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
                              Row(
                                children: [
                                  Text(
                                    lesson.name.replaceAll("\n", ""),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${lesson.teacher.replaceAll("\n", "")} ${lesson.classroom}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Text(lesson.time.replaceAll("\n", "")),
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
