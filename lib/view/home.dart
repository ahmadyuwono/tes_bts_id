import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_bts_id/model/checklist_model.dart';
import 'package:tes_bts_id/preference_helper.dart';
import 'package:tes_bts_id/viewmodel/auth_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  late PreferencesHelper _preferencesHelper;
  List<Checklist> data = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _preferencesHelper =
        PreferencesHelper(sharedPreference: SharedPreferences.getInstance());
    getChecklist();
  }

  Future<void> getChecklist() async {
    setState(() {
      isLoading = true;
    });
    final token = await _preferencesHelper.getToken();
    AuthRepository.getChecklistRepository(token).then((value) {
      setState(() {
        if (value.data != null) {
          data = value.data!;
        }
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
        print(data[0].checklistCompletionStatus);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: isLoading == true && data.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return TextFormField(
                        controller: _controller,
                      );
                    }
                    return ListTile(
                      leading: Checkbox(
                          value: data[index]
                                      .checklistCompletionStatus
                                      .toString() ==
                                  'false'
                              ? false
                              : true,
                          onChanged: (value) {}),
                      title: Text(data[index].name!),
                      trailing: GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.delete),
                      ),
                    );
                  }),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
