import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:libellus/model/teacher_schedule/teacher.dart';
import 'package:libellus/repo/libellus_server_repo.dart';
import 'package:libellus/ui/widget/route/teacher_schedule/teacher_lesson_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'teacher_day_widget.dart';

class TeacherScheduleWidget extends StatefulWidget {
  const TeacherScheduleWidget({super.key});

  @override
  State<TeacherScheduleWidget> createState() => _TeacherScheduleWidgetState();
}

class _TeacherScheduleWidgetState extends State<TeacherScheduleWidget> {
  List<Teacher>? teacherSchedule;
  late List<TeacherDayWidget> teacherDays;
  late List<DropdownMenuItem<Teacher>> teachers;
  final PageController _pageController = PageController();
  String _pageName = '';
  Teacher? selectedTeacher;
  int currentPage = 0;
  @override
  void initState() {
    teachers = List.empty(growable: false);
    teacherDays = List.empty(growable: false);
    _getTeacherSchedule();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toInt();
        _updatePageName();
        _sortTeacherLessons();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return teacherSchedule == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                SizedBox.fromSize(
                  size: const Size.fromHeight(50),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        label: const Text("Преподаватель"),
                        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 3, color: Colors.teal))),
                    borderRadius: BorderRadius.circular(12),
                    focusColor: ThemeData().canvasColor,
                    items: teachers,
                    value: selectedTeacher,
                    onChanged: (value) {
                      setState(() {
                        selectedTeacher = value;
                        _sortTeacherWeek();
                        _updatePageName();
                        _sortTeacherLessons();
                      });
                    },
                  ),
                ),
                Expanded(
                    child: Scaffold(
                        body: Container(
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.center,
                          child: (selectedTeacher == null ||
                                  selectedTeacher!.week.isEmpty)
                              ? Container()
                              : PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedTeacher!.week.length,
                                  controller: _pageController,
                                  itemBuilder: (context, index) {
                                    currentPage = index;
                                    var lessons = selectedTeacher!
                                        .week[currentPage].lessons;
                                    return ListView.builder(
                                        itemBuilder: (context, index) {
                                          return TeacherLessonWidget(
                                              teacherLesson: lessons[index]);
                                        },
                                        itemCount: lessons.length);
                                  },
                                  allowImplicitScrolling: false,
                                ),
                        ),
                        bottomNavigationBar: _bottomPageBar()))
                // Expanded(
                //     child: CustomScrollView(
                //   slivers: teacherDays ?? [],
                // ))
                // Expanded(
                //     child: ListView.builder(
                //         itemCount: teacherDays.length,
                //         itemBuilder: (context, index) {
                //           return teacherDays[index];
                //         }))
              ],
            ),
          );
  }

  Widget _bottomPageBar() {
    return ConstrainedBox(
        constraints: BoxConstraints.tight(const Size.fromHeight(40)),
        child: Column(
          children: [
            Text(_pageName.replaceAll("\n", "").replaceAll(" ", "")),
            SmoothPageIndicator(
              controller: _pageController,
              count: selectedTeacher == null ? 0 : selectedTeacher!.week.length,
              effect:
                  WormEffect(activeDotColor: Theme.of(context).primaryColor),
            )
          ],
        ));
  }

  List<DropdownMenuItem<Teacher>> _loadTeachers() {
    if (teacherSchedule!.isNotEmpty) {
      List<DropdownMenuItem<Teacher>> l = List.empty(growable: true);
      for (var teacher in teacherSchedule!) {
        l.add(DropdownMenuItem<Teacher>(
          value: teacher,
          child: Text(teacher.name),
        ));
      }
      return l;
    }
    return [];
  }

  Future<void> _getTeacherSchedule() async {
    var data = await getAllTeacherSchedule();
    setState(() {
      teacherSchedule = data;
      teachers = _loadTeachers();
    });
  }

  void _sortTeacherWeek() {
    if (selectedTeacher != null) {
      selectedTeacher!.week.sort((a, b) => _compareDates(a.date, b.date));
    }
  }

  void _updatePageName() {
    _pageName = selectedTeacher == null
        ? ''
        : selectedTeacher!.week.elementAt(currentPage).date;
  }

  int _compareDates(String a, String b) {
    var dateA = DateFormat("dd.MM.yyyy").parse(a);
    var dateB = DateFormat("dd.MM.yyyy").parse(b);
    return dateA.compareTo(dateB);
  }

  void _sortTeacherLessons() {
    if (selectedTeacher != null) {
      selectedTeacher!.week
          .elementAt(currentPage)
          .lessons
          .sort((a, b) => _compareLessonTime(a.time, b.time));
    }
  }

  int _compareLessonTime(String a, String b) {
    try {
      var aHoursMinutes =
          a.replaceAll(' ', '').split('-').slices(2).elementAt(0)[0].split(':');
      var bHoursMinutes =
          b.replaceAll(' ', '').split('-').slices(2).elementAt(0)[0].split(':');
      var aDateTime = DateTime(
          1970, 1, 1, int.parse(aHoursMinutes[0]), int.parse(aHoursMinutes[1]));
      var bDateTime = DateTime(
          1970, 1, 1, int.parse(bHoursMinutes[0]), int.parse(bHoursMinutes[1]));
      return aDateTime.compareTo(bDateTime);
    } catch (e) {
      return 0;
    }
  }
}
