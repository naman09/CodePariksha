import 'package:code_pariksha/enums/answer_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code_pariksha/choice_button.dart';

export 'package:code_pariksha/quiz_page.dart';

class QuizPageState extends ChangeNotifier {
  int quizIndex = 0;
  bool quizDone = false;

  final List<Map<String, dynamic>> quizzes = [
    {
      'questionText': 'What is H20 ?',
      'multiChoice': ['Water', 'Air', 'Fire', 'Earth',],
      'answer': 'Water',
      'reasonText': 'water is formed of 2 hydrogen atoms bonded to an oxygen atom'
    },
    {
      'questionText': 'What is O2 ??',
      'multiChoice': ['Water', 'Air', 'Fire', 'Earth',],
      'answer': 'Air',
      'reasonText': 'air is formed of 2 oygen atoms'
    }
  ];

  void nextQuiz() {
    if (quizIndex >= quizzes.length - 1) {
      quizDone = true;
    } else {
      quizIndex++;
    }
    notifyListeners();
  }
}

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    var quizPageState = context.watch<QuizPageState>();
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!quizPageState.quizDone)
                Quiz(
                  key: Key('quiz_${quizPageState.quizIndex}'),
                  questionText: quizPageState.quizzes[quizPageState.quizIndex]['questionText'],
                  multiChoice: quizPageState.quizzes[quizPageState.quizIndex]['multiChoice'],
                  answer: quizPageState.quizzes[quizPageState.quizIndex]['answer'],
                  reasonText: quizPageState.quizzes[quizPageState.quizIndex]['reasonText'],
                ),
              if (quizPageState.quizDone)
                const Text('Congo! Quiz complete'),
            ],
          )
        ),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key, required this.questionText, required this.multiChoice, required this.answer, this.reasonText = '',});

  final String questionText;
  final List<String> multiChoice;
  final String answer;
  final String reasonText;

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  AnswerState answerState = AnswerState.notAnsweredYet;

  setAnswerState(correct) {
    setState(() {
      answerState = correct ? AnswerState.correct : AnswerState.incorrect;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Question(questionText: widget.questionText),
        MultipleChoice(multiChoice: widget.multiChoice, answer: widget.answer, setAnswerState: setAnswerState),
        QuizAnswerOutput(answerState: answerState, reasonText: widget.reasonText,)
      ],
    );
  }
}

class QuizAnswerOutput extends StatelessWidget {
  const QuizAnswerOutput({super.key, required this.answerState, this.reasonText = ''});

  final AnswerState answerState;
  final String reasonText;

  @override
  Widget build(BuildContext context) {
    var quizPageState = context.watch<QuizPageState>();

    String answer = 'Your answer is: ';

    if (answerState == AnswerState.correct) {
      answer += 'correct';
    } else if (answerState == AnswerState.incorrect) {
      answer += 'incorrect';
    }

    List<Widget> children = <Widget>[
      Text(answer, style: Theme.of(context).textTheme.bodyLarge),
    ];

    if (answerState != AnswerState.notAnsweredYet) {
      children.add(const SizedBox(height: 10));
      children.add(Text(reasonText, style: Theme.of(context).textTheme.bodyMedium));
      children.add(const SizedBox(height: 10));
      children.add(
        ElevatedButton(
          onPressed: quizPageState.nextQuiz, 
          child: const Text('Next'),
        )
      );
    }
            


    return Center(
      child: Column(
        children: children
      )
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
  const MultipleChoice({super.key, required this.multiChoice, required this.answer, required this.setAnswerState});

  final List<String> multiChoice;
  final String answer;
  final Function setAnswerState;

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {

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
              widget.setAnswerState(widget.answer == choiceLabel);
            }
          ),
      ],
    );
  }
}