import 'package:flutter/material.dart';
import 'package:libellus/model/consultations/consult_teacher.dart';
import 'package:libellus/repo/libellus_server_repo.dart';
import 'package:libellus/ui/widget/route/consultations/consult_day_widget.dart';

class ConsultationsWidget extends StatefulWidget {
  const ConsultationsWidget({super.key});

  @override
  State<ConsultationsWidget> createState() => _ConsultationsWidgetState();
}

class _ConsultationsWidgetState extends State<ConsultationsWidget> {
  Map<String, List<ConsultTeacher>>? _consultations;
  late List<DropdownMenuItem<ConsultTeacher>>? _teachers;
  late List<DropdownMenuItem<String>>? _weeks;
  ConsultTeacher? _selectedTeacher;
  String? _selectedWeek;

  @override
  void initState() {
    _fetchConsultations();
    _teachers = List.empty(growable: false);
    _weeks = List.empty(growable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _consultations == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                SizedBox.fromSize(
                  size: const Size.fromHeight(50),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        label: const Text("Неделя"),
                        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 3, color: Colors.teal))),
                    borderRadius: BorderRadius.circular(12),
                    focusColor: const ColorScheme.light().background,
                    items: _weeks,
                    value: _selectedWeek,
                    onChanged: (value) {
                      setState(() {
                        _selectedWeek = value;
                        _teachers = _loadTeachersList();
                        _selectedTeacher = null;
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
                  child: DropdownButtonFormField<ConsultTeacher>(
                    decoration: InputDecoration(
                        label: const Text("Преподаватель"),
                        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 3, color: Colors.teal))),
                    borderRadius: BorderRadius.circular(12),
                    focusColor: ThemeData().canvasColor,
                    items: _teachers,
                    value: _selectedTeacher,
                    onChanged: (value) {
                      setState(() {
                        _selectedTeacher = value;
                      });
                    },
                  ),
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: ListView.builder(
                        itemCount: _selectedTeacher == null
                            ? 0
                            : _selectedTeacher!.week.length,
                        itemBuilder: (context, index) {
                          return ConsultDayWidget(
                              day: _selectedTeacher!.week[index]);
                        }))
              ],
            ));
  }

  List<DropdownMenuItem<String>> _loadWeeksList() {
    List<DropdownMenuItem<String>> list = List.empty(growable: true);
    for (var date in _consultations!.keys) {
      list.add(DropdownMenuItem<String>(
          value: date, child: Text(date.replaceAll("_", "."))));
    }
    return list;
  }

  List<DropdownMenuItem<ConsultTeacher>> _loadTeachersList() {
    List<DropdownMenuItem<ConsultTeacher>> list = List.empty(growable: true);
    if (_selectedWeek != null && _consultations!.containsKey(_selectedWeek)) {
      var teachers = _consultations![_selectedWeek];
      for (int i = 0; i < teachers!.length; i++) {
        list.add(DropdownMenuItem<ConsultTeacher>(
            value: teachers[i], child: Text(teachers[i].name)));
      }
    }
    return list;
  }

  Future<void> _fetchConsultations() async {
    var consultations = await getAllTeacherConsultations();
    setState(() {
      _consultations = consultations;
      _weeks = _loadWeeksList();
    });
  }
}
