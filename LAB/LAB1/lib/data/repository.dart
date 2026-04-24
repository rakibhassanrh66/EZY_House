import 'package:shared_preferences/shared_preferences.dart';

class StudentRepository {
  static const _nameKey = 'student_name';
  static const _digitsKey = 'student_digits';

  static Future<void> saveData(String name, String digits) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_nameKey, name);
      await prefs.setString(_digitsKey, digits);
    } catch (_) {
      // Silent fail for storage; app still works in-memory
    }
  }

  static Future<Map<String, String>> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return {
        'name': prefs.getString(_nameKey) ?? '',
        'digits': prefs.getString(_digitsKey) ?? '',
      };
    } catch (_) {
      return {'name': '', 'digits': ''};
    }
  }

  static Future<void> clearData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_nameKey);
      await prefs.remove(_digitsKey);
    } catch (_) {}
  }
}
