import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
  static final Preferences _instance = Preferences._internal();

  static late SharedPreferences preferences;

  static Future<void> setPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() {
    return preferences.clear();
  }

  static Future<void> reload() {
    return preferences.reload();
  }

  static Future<bool> remove(String key) {
    return preferences.remove(key);
  }

  static Future<bool> setBool(String key, bool value) {
    return preferences.setBool(key, value);
  }

  static Future<bool> setString(String key, String value) {
    return preferences.setString(key, value);
  }

  static String? getString(String key) {
    return preferences.getString(key);
  }

  static bool? getBool(String key) {
    return preferences.getBool(key);
  }
}
