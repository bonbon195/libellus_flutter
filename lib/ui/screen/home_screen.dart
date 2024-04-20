import 'package:flutter/material.dart';
import 'package:libellus/repo/libellus_server_repo.dart';
import 'package:libellus/ui/widget/route/consultations/consultations_route.dart';
import 'package:libellus/ui/widget/route/settings/settings_route.dart';
import 'package:libellus/ui/widget/route/student_schedule/student_schedule_route.dart';
import '../widget/route/teacher_schedule/teacher_schedule_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String title = '';
  String _updateDate = '';
  late final List<Widget> _routes;

  @override
  initState() {
    super.initState();
    _routes = [
      StudentSchedule(
        setTitle: setTitle,
      ),
      const SettingsWidget(isLoginScreen: false),
      const ConsultationsWidget(),
      const TeacherScheduleWidget()
    ];
    _fetchUpdateDate();
  }

  setTitle(String newValue) {
    Future.delayed(
        Duration.zero,
        () => setState(() {
              title = newValue;
            }));
  }

  void _onItemTapped(int index) {
    setState(() {
      Navigator.pop(context);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer:
                NavigationDrawer(onDestinationSelected: (value) {}, children: [
              ListTile(
                title: const Text("Расписание"),
                onTap: () {
                  _onItemTapped(0);
                },
              ),
              ListTile(
                title: const Text("Настройки"),
                onTap: () {
                  _onItemTapped(1);
                },
              ),
              ListTile(
                title: const Text("Консультации"),
                onTap: () {
                  _onItemTapped(2);
                },
              ),
              ListTile(
                title: const Text("Преподаватели"),
                onTap: () {
                  _onItemTapped(3);
                },
              ),
              ListTile(
                title: Text(
                  "Последнее обновление:\n$_updateDate",
                ),
                enabled: false,
              )
            ]),
            appBar: AppBar(
              title: Text(title),
            ),
            body: _routes[_selectedIndex]));
  }

  Future<void> _fetchUpdateDate() async {
    String date = await getUpdateDate();
    setState(() {
      _updateDate = date;
    });
  }
}
