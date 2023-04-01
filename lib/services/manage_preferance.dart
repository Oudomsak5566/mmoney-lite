import 'package:shared_preferences/shared_preferences.dart';

class ManagePreferance {
  Future<void> setStringPreferance(String name, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(name, value);
  }

  Future<String> getStringPreferance1(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(name).toString();
    print('### $value');
    return value;
  }

  Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('msisdn');
    prefs.remove('token');
  }
}
