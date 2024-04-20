import 'package:flutter/material.dart';
import 'package:libellus/model/student_schedule/faculty.dart';
import 'package:libellus/model/student_schedule/group.dart';
import 'package:libellus/preferences/user_preferences.dart';
import 'package:libellus/repo/libellus_server_repo.dart';
import 'package:libellus/ui/screen/home_screen.dart';
import 'package:collection/collection.dart';

class SettingsWidget extends StatefulWidget {
  final bool isLoginScreen;
  const SettingsWidget({super.key, required this.isLoginScreen});

  @override
  State<SettingsWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  final TextEditingController facultyController = TextEditingController();
  final TextEditingController groupController = TextEditingController();

  String _faculty = '';
  String _group = '';
  Faculty? selectedFaculty;
  Group? selectedGroup;
  List<Faculty>? _schedule;
  late List<DropdownMenuItem<Faculty>> faculties;
  late List<DropdownMenuItem<Group>> groups;

  @override
  void initState() {
    _faculty = UserPreferences.getFaculty();
    _group = UserPreferences.getGroup();
    faculties = List.empty(growable: false);
    groups = List.empty(growable: false);
    _getSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _schedule == null
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: SizedBox.fromSize(
            size: const Size.fromWidth(250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox.fromSize(
                  size: const Size.fromHeight(50),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        label: const Text("Специальность"),
                        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 3, color: Colors.teal))),
                    borderRadius: BorderRadius.circular(12),
                    focusColor: ThemeData().canvasColor,
                    items: faculties,
                    value: selectedFaculty,
                    onChanged: (value) {
                      setState(() {
                        selectedFaculty = value;
                        groups = _loadGroupList();
                        selectedGroup = null;
                      });
                    },
                  ),
                ),
                const Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                SizedBox.fromSize(
                  size: const Size.fromHeight(50),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        label: const Text("Группа"),
                        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 3, color: Colors.teal))),
                    borderRadius: BorderRadius.circular(12),
                    focusColor: const ColorScheme.light().background,
                    items: groups,
                    value: selectedGroup,
                    onChanged: (value) {
                      setState(() {
                        selectedGroup = value;
                      });
                    },
                  ),
                ),
                const Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: OutlinedButton(
                      onPressed: saveToPreferences,
                      child: const Text("Сохранить")),
                )
              ],
            ),
          ));
  }

  void saveToPreferences() async {
    if (selectedGroup != '' && selectedFaculty != '') {
      await UserPreferences.setGroupAndFaculty(
          selectedGroup!.name, selectedFaculty!.code);
      if (widget.isLoginScreen) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    }
  }

  List<DropdownMenuItem<Faculty>> _loadFacultyList() {
    List<DropdownMenuItem<Faculty>> list = List.empty(growable: true);
    if (_schedule!.isNotEmpty) {
      for (int i = 0; i < _schedule!.length; i++) {
        list.add(DropdownMenuItem<Faculty>(
            value: _schedule![i], child: Text(_schedule![i].code)));
      }
    }
    return list;
  }

  List<DropdownMenuItem<Group>> _loadGroupList() {
    List<DropdownMenuItem<Group>> list = List.empty(growable: true);
    if (selectedFaculty != null) {
      for (var group in selectedFaculty!.groups) {
        list.add(
            DropdownMenuItem<Group>(value: group, child: Text(group.name)));
      }
    }
    return list;
  }

  void _getSchedule() async {
    var schedule = await getAllStudentSchedule();
    if (schedule.isEmpty) {
      return;
    }
    setState(() {
      _schedule = schedule;
      selectedFaculty = _schedule?.firstWhereOrNull((f) => f.code == _faculty);
      selectedGroup = selectedFaculty == null
          ? null
          : selectedFaculty!.groups
              .firstWhereOrNull((element) => element.name == _group);
      faculties = _loadFacultyList();
      if (selectedGroup != null) {
        groups = _loadGroupList();
      }
    });
  }
}
