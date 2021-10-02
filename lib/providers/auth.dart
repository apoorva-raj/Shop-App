import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiry;
  late String _UserId;

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
}
