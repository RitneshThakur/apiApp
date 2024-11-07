import 'package:apiapp/pages/homepage.dart';
import 'package:apiapp/pages/joke_page.dart';
import 'package:apiapp/pages/pickup_page.dart';
import 'package:apiapp/pages/quote_page.dart';
import 'package:apiapp/pages/shayari_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home-page":(context)=>Homepage(),
        "/joke-page":(context)=>JokePage(),
        "/poetry-page":(context)=>PoetryPage(),
        "/quotes-page":(context)=>QuotePage(),
        "/pickup-page":(context)=>PickUpLine(),
      },
      home: const Homepage(),
    );
  }
}
