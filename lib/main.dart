import 'package:code_pariksha/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ChangeNotifierProvider(
            create: (context) => QuizPageState(),
            child: QuizPage(),
          )
        ),
      ),
    );
  }
}