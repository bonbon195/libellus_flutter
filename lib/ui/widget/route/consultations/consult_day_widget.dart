import 'package:flutter/material.dart';
import 'package:libellus/model/consultations/consult_day.dart';

class ConsultDayWidget extends StatelessWidget {
  final ConsultDay day;
  const ConsultDayWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
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
                                    day.date
                                        .replaceAll("\n", "")
                                        .replaceAll("-", "."),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    " ${day.name.replaceAll("\n", "")}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    day.classroom.replaceAll("\n", ""),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Text(day.time.replaceAll("\n", "")),
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
