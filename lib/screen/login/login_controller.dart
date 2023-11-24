import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController(text: "kminchelle");
  TextEditingController password = TextEditingController(text: "0lelplR");

  static final _loginUrl = Uri.parse('https://dummyjson.com/auth/login');

  void login() async {
    var response = await http.post(_loginUrl, body: {
      "username": username.text,
      "password": password.text,
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      await Get.toNamed('/home');
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
}
