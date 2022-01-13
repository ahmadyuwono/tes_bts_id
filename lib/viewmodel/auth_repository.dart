import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tes_bts_id/constants.dart';
import 'package:tes_bts_id/model/auth_model.dart';
import 'package:tes_bts_id/model/checklist_model.dart';

class AuthRepository {
  static Future<AuthModel> loginRepository(
      String password, String username) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      'password': '$password',
      'username': '$username',
    };

    final result = await http.post(Uri.parse(baseUrl + login),
        headers: headers, body: jsonEncode(body));
    return AuthModel.fromJson(jsonDecode(result.body));
  }

  static Future<AuthModel> registerRepository(
      String password, String username, String email) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      'email': '$email',
      'password': '$password',
      'username': '$username',
    };

    final result = await http.post(Uri.parse(baseUrl + register),
        headers: headers, body: jsonEncode(body));
    print(result);
    return AuthModel.fromJson(jsonDecode(result.body));
  }

  static Future<ChecklistModel> getChecklistRepository(String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
    };

    print(token);
    // final body = {
    //   'email': '$email',
    //   'password': '$password',
    //   'username': '$username',
    // };

    final result =
        await http.get(Uri.parse(baseUrl + checklist), headers: headers);
    print(result.body);
    return ChecklistModel.fromJson(jsonDecode(result.body));
  }

  static Future<bool> createChecklistRepository(
      String token, String name) async {
    final headers = {
      'Authorization': 'Bearer $token',
    };

    print(token);
    final body = {
      'name': '$name',
    };

    final result = await http.post(Uri.parse(baseUrl + checklist),
        headers: headers, body: jsonEncode(body));
    print(result.statusCode);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteChecklistRepository(String token, int id) async {
    final headers = {
      'Authorization': 'Bearer $token',
    };

    print(token);

    final result = await http.delete(Uri.parse(baseUrl + checklist + '/$id'),
        headers: headers);
    print(result.body);
    if (result.statusCode == 2000) {
      return true;
    } else {
      return false;
    }
  }
}
