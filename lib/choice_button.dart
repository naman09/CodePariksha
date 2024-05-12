import 'package:flutter/material.dart';

export 'package:code_pariksha/choice_button.dart';

class ChoiceButton extends StatelessWidget {
  final String option;
  final bool isSelected;
  final Function onSelect;

  const ChoiceButton({super.key, required this.option, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: onSelect(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              isSelected ? Colors.blue : Colors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              option,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
    );
  }
}