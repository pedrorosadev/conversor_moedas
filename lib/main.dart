import 'package:conversor_moedas/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const request =
    'https://api.hgbrasil.com/finance?format=json&key=25672a2d'; // API's HG Finance

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
    theme: ThemeData(
      hintColor: Colors.white,
      primaryColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(
    Uri.parse(
      (request),
    ),
  );
  return json.decode(response.body);
}
