import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreference;
  PreferencesHelper({required this.sharedPreference});
  static const TOKEN = 'token';

  Future<String> getToken() async {
    final prefs = await sharedPreference;
    return prefs.getString(TOKEN) ?? "";
  }

  void setToken(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(TOKEN, value);
  }
}
