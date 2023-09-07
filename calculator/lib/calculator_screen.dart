import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: Text(equation),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(result),
          ),
          const Expanded(
            child: Divider(
              thickness: 2,
              color: Colors.black,
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('+'),
                ],
              ),
              Row(
                children: [
                  _buildButton('DEL'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: [
                  _buildButton('CLEAR'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String equation = '0';
  String result = '0';
  String expression = ' ';

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'CLEAR') {
        equation = '0';
        result = '0';
        expression = '0';
      } else if (buttonText == 'DEL') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(equation);
          ContextModel contextModel = ContextModel();
          double result1 = exp.evaluate(EvaluationType.REAL, contextModel);
          result = result1.toStringAsFixed(2);
        } catch (e) {
          'Syntax error';
        }
      } else {
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
        child: SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsetsDirectional.all(3),
        child: OutlinedButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(buttonText),
        ),
      ),
    ));
  }
}
