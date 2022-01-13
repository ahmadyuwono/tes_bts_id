import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_bts_id/preference_helper.dart';
import 'package:tes_bts_id/view/home.dart';
import 'package:tes_bts_id/view/login.dart';
import 'package:tes_bts_id/viewmodel/auth_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late PreferencesHelper _preferencesHelper;
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>(debugLabel: 'register');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _preferencesHelper =
        PreferencesHelper(sharedPreference: SharedPreferences.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(
                  height: 48,
                ),
                Text(
                  'Register Form',
                  style: Theme.of(context).textTheme.headline4,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (username) => username == null || username.isEmpty
                      ? 'Enter email'
                      : null,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: _emailFocusNode.hasFocus
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[600]),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (password) => password == null || password.isEmpty
                      ? 'Enter password'
                      : null,
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: _passwordFocusNode.hasFocus
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[600]),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _usernameController,
                  validator: (username) => username == null || username.isEmpty
                      ? 'Enter username'
                      : null,
                  focusNode: _usernameFocusNode,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        color: _usernameFocusNode.hasFocus
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[600]),
                  ),
                ),
                ButtonBar(
                  children: [
                    TextButton(
                      child: Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()));
                      },
                    ),
                    ElevatedButton(
                      child: Text(
                        'SIGN UP',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                        elevation: MaterialStateProperty.all(6.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response =
                              await AuthRepository.registerRepository(
                                  _passwordController.text,
                                  _usernameController.text,
                                  _emailController.text);
                          if (response.statusCode == 2000) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login Success')));
                            final result = await AuthRepository.loginRepository(
                                _passwordController.text,
                                _usernameController.text);
                            print(result);
                            if (result.data != null) {
                              _preferencesHelper
                                  .setToken(result.data!['token']);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const MyHomePage(title: 'Home')));
                            }
                          }
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
