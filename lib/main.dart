import 'package:app_test/UI/views/greetings_view.dart';
import 'package:flutter/material.dart';
import 'package:app_test/helpers/dependency_assembly.dart';
import 'helpers/color_utils.dart';

void main() {
  setupDependencyAssemble();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorUtils.primaryColor,
        accentColor: ColorUtils.secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GreetingsView()
    );
  }
}