import 'package:code_pariksha/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: QuizPage()
        ),
      ),
    );
  }
}

enum QuizAnswer {notAnswered, correct, incorrect}

class QuizState extends ChangeNotifier {
  QuizAnswer quizAnswerState = QuizAnswer.notAnswered;

  void setQuizAnswer(correct) {
    quizAnswerState = correct ? QuizAnswer.correct : QuizAnswer.incorrect;
    notifyListeners();
  }
}

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizState(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Quiz()
            ],
          )
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  Quiz({super.key});

  final questionText = 'What is H20 ??';

  final multiChoice = [
    'Water',
    'Air',
    'Fire',
    'Earth',
  ];

  final answer = 'Water';

  @override
  Widget build(BuildContext context) {
    var quizState = context.watch<QuizState>();

    return Column(
      children: [
        Question(questionText: questionText),
        MultipleChoice(multiChoice: multiChoice, answer: answer),
        QuizAnswerOutput(quizAnswer: quizState.quizAnswerState)
      ],
    );
  }
}

class QuizAnswerOutput extends StatelessWidget {
  const QuizAnswerOutput({super.key, required this.quizAnswer});

  final QuizAnswer quizAnswer;

  @override
  Widget build(BuildContext context) {

    String answer = 'Your answer is: ';

    if (quizAnswer == QuizAnswer.correct) {
      answer += 'correct';
    } else if (quizAnswer == QuizAnswer.incorrect) {
      answer += 'incorrect';
    }

    return Center(
      child: Text(answer),
    );
  }
}

class Question extends StatelessWidget {
  const Question({super.key, required this.questionText});

  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        questionText,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key, required this.multiChoice, required this.answer});

  final List<String> multiChoice;
  final String answer;

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var quizState = context.watch<QuizState>();

    return Column(
      children: [
        for (var choiceLabel in widget.multiChoice)
          ChoiceButton(
            option: choiceLabel, 
            isSelected: selectedOption == choiceLabel, 
            onSelect: () => () {
              setState(() {
                selectedOption = choiceLabel;
              });
              quizState.setQuizAnswer(widget.answer == choiceLabel);
            }
          ),
      ],
    );
  }
}