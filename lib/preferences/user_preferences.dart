import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyFaculty = "faculty";
  static const _keyGroup = "group";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setEmptyValues() async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({_keyFaculty: '', _keyGroup: ''});
  }

  static Future setGroupAndFaculty(String group, String faculty) async {
    await _preferences.setString(_keyFaculty, faculty);
    await _preferences.setString(_keyGroup, group);
  }

  static Future setGroup(String group) async {
    await _preferences.setString(_keyGroup, group);
  }

  static String getFaculty() => _preferences.getString(_keyFaculty) ?? '';
  static String getGroup() => _preferences.getString(_keyGroup) ?? '';
}
