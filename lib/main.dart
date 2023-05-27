import 'package:flutter/material.dart';
import 'package:multiply/ui/others/colors.dart';
import 'package:multiply/ui/screens/home.dart';
import 'package:multiply/view_model/home_view_model.dart';
import 'package:multiply/view_model/list_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ChangeNotifierProvider(create: (context) => ListViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: blackSwatch,
      ),
      home: Home(),
    );
  }
}
