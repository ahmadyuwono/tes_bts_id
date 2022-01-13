import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_bts_id/preference_helper.dart';
import 'package:tes_bts_id/view/home.dart';
import 'package:tes_bts_id/view/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PreferencesHelper _preferencesHelper;
  String token = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _preferencesHelper =
        PreferencesHelper(sharedPreference: SharedPreferences.getInstance());
    _preferencesHelper.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: token.isNotEmpty
          ? const MyHomePage(title: 'Home')
          : const LoginPage(),
    );
  }
}
