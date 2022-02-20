import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/models/AppModel.dart';
import 'package:toodoo/views/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TooDoo',
      home: ScopedModel(model: AppModel(), child: HomePage()),
    );
  }
}
