import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libellus/model/student_schedule/group.dart';
import 'package:libellus/preferences/user_preferences.dart';
import 'package:libellus/repo/libellus_server_repo.dart';
import 'package:libellus/ui/screen/login_screen.dart';
import 'lesson.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StudentSchedule extends StatefulWidget {
  final Function(String) setTitle;

  const StudentSchedule({super.key, required this.setTitle});

  @override
  State<StudentSchedule> createState() => _StudentSchedulePageState();
}

class _StudentSchedulePageState extends State<StudentSchedule> {
  Group? _schedule;
  String _pageName = '';
  late String faculty;
  late String group;
  late PageController _pageController =
      PageController(initialPage: initialPage);
  int currentPage = 0;
  int initialPage = 0;
  DateTime now = DateTime.now();

  @override
  void initState() {
    setGroupAndFaculty();
    if (faculty != "" && group != "") {
      Future.delayed(Duration.zero, () async {
        await _getSchedule();
        _initPageController();
        _updatePageName();
      });
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    widget.setTitle(group);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toInt();
        _updatePageName();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // minimum: kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS)
        minimum: (defaultTargetPlatform == TargetPlatform.iOS)
            ? const EdgeInsets.only(bottom: 12)
            : const EdgeInsets.all(0),
        bottom: true,
        child: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: (_schedule == null || _schedule!.days.isEmpty)
                  ? const CircularProgressIndicator()
                  : PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _schedule!.days.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        currentPage = index;
                        var lessons =
                            _schedule!.days.elementAt(currentPage).lessons;
                        return ListView.builder(
                            itemBuilder: (context, index) {
                              return LessonWidget(lesson: lessons[index]);
                            },
                            itemCount: lessons.length);
                      },
                      allowImplicitScrolling: false,
                    ),
            ),
            bottomNavigationBar: _bottomPageBar()));
  }

  Widget _bottomPageBar() {
    return ConstrainedBox(
        constraints: BoxConstraints.tight(const Size.fromHeight(40)),
        child: Column(
          children: [
            Text(_pageName),
            SmoothPageIndicator(
              controller: _pageController,
              count: _schedule == null ? 0 : _schedule!.days.length,
              effect:
                  WormEffect(activeDotColor: Theme.of(context).primaryColor),
            )
          ],
        ));
  }

  void _initPageController() {
    _pageController.dispose();
    _pageController = PageController(initialPage: initialPage);
    currentPage = initialPage;
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toInt();
        _updatePageName();
      });
    });
  }

  int calculateDifference(DateTime date) {
    var dif = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inHours;
    return dif;
  }

  void _updatePageName() {
    _pageName = _schedule == null
        ? ''
        : "${_schedule!.days.elementAt(currentPage).date} ${_schedule!.days.elementAt(currentPage).name}";
  }

  void setInitialPage() {
    // // excuse me what the fucc is this?
    // var m = now.month < 10 ? "0${now.month}" : "${now.month}";
    // var currentDateString = "${now.day}-${m}-${now.year}";
    // var currentDate = DateFormat("dd-MM-yyyy").parse(currentDateString);
    // var dates = _schedule!.days.toList();
    // var difference =
    //     calculateDifference(DateFormat("dd-MM-yyyy").parse(dates.last.date));
    initialPage = 0;
    //TODO
    // if (_schedule!.containsKey(currentDateString)) {
    //   initialPage = dates.indexOf(currentDateString);
    // } else if (difference <= 3 && difference >= 0 || difference == 0) {
    //   initialPage = dates.length - 1;
    // } else if (currentDate.weekday == 7 &&
    //     difference >= 0 &&
    //     dates.indexOf(currentDateString) != dates.length - 1) {
    //   initialPage = dates.indexOf(currentDateString) + 1;
    // } else {
    //   initialPage = 0;
    // }
  }

  setGroupAndFaculty() {
    faculty = UserPreferences.getFaculty();
    group = UserPreferences.getGroup();
  }

  Future<void> _getSchedule() async {
    try {
      var schedule = await getGroupStudentSchedule(faculty, group);
      setState(() {
        _schedule = schedule;
        setInitialPage();
      });
    } catch (exception) {
      debugPrint(exception.toString());
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }
}
