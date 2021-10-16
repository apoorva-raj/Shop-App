import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiry;
  String? _UserId;
  bool get isAuth {
    print(token != null);
    return token != null;
  }

  String? get token {
    if (_token != null && _expiry != null && _expiry!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDI97PQePWmlEhQa_Ov9ggM40X0b4H_Piw';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );
    print(json.decode(response.body));
  }

  Future<void> login(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDI97PQePWmlEhQa_Ov9ggM40X0b4H_Piw';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );
    final responseBody = json.decode(response.body);
    _token = responseBody['idToken'];
    _UserId = responseBody['localId'];
    _expiry = DateTime.now()
        .add(Duration(seconds: int.parse(responseBody['expiresIn'])));
    print(json.decode(response.body));
    notifyListeners();
  }
}
