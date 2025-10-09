import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorState());

  void enterNumber(int number) {

if (state.expression == "Enter any number first" ||
      state.expression == "Error" ||
      state.expression == "can't divide by zero") {
    emit(
      state.copyWith(
        firstNum: number.toString(),
        expression: number.toString(),
        operator: null,
        secondNum: null,
        showResult: false,
        result: null,
      ),
    );
    return;
  }

    if (state.showResult) {
      emit(
        state.copyWith(
          firstNum: number.toString(),
          expression: number.toString(),
          operator: null,
          secondNum: null,
          showResult: false,
          result: null,
        ),
      );
    } else if (state.operator == null) {
      final newValue = (state.firstNum ?? "") + number.toString();
      emit(
        state.copyWith(
          firstNum: newValue,
          expression: state.expression + number.toString(),
          showResult: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          secondNum: number.toString(),
          expression: state.expression + number.toString(),
          showResult: false,
        ),
      );
    }
  }

  ///////////////////////////////
  void addDecimalPoint() {
    if (state.operator == null) {
      if (!(state.firstNum ?? "").contains(".")) {
        final newValue = (state.firstNum ?? "0") + ".";
        emit(
          state.copyWith(
            firstNum: newValue,
            expression: state.expression + ".",
            showResult: false,
          ),
        );
      }
    } else {
      if (!(state.secondNum ?? "").contains(".")) {
        final newValue = (state.secondNum ?? "0") + ".";
        emit(
          state.copyWith(
            secondNum: newValue,
            expression: state.expression + ".",
            showResult: false,
          ),
        );
      }
    }
  }

  ////////////////////////
  void chooseOperator(String op) {
    if (state.showResult) {
      emit(
        state.copyWith(
          expression: "${state.result}$op",
          firstNum: state.result.toString(),
          operator: op,
          secondNum: null,
          showResult: false,
        ),
      );
    } else if (state.firstNum != null && state.operator == null) {
      emit(
        state.copyWith(
          operator: op,
          expression: "${state.expression}$op",
          showResult: false,
        ),
      );
    } else if (state.operator != null && state.secondNum != null) {
      calculate();
      if (state.showResult) {
        emit(
          state.copyWith(
            expression: "${state.result}$op",
            firstNum: state.result.toString(),
            operator: op,
            secondNum: null,
            showResult: false,
          ),
        );
      }
    }
  }

  ///////////////////////////////////
  void calculate() {
    try {
      final parser = Parser();
      final context = ContextModel();

      final exp = parser.parse(
        state.expression.replaceAll('X', '*').replaceAll('÷', '/'),
      );

      final res = exp.evaluate(EvaluationType.REAL, context);

      if (res.isInfinite || res.isNaN) {
        emit(
          state.copyWith(
            expression: "can't divide by zero",
            result: 0,
            showResult: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            result: res,
            // expression: res.toString(),
            showResult: true,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(expression: "Error", result: 0, showResult: true));
    }
  }

  ///////////////////////////
  void applyPercentage() {
    if (state.expression.isEmpty) return;

    try {
      if (state.showResult && state.result != null) {
        num currentValue = state.result!;
        double percentValue = currentValue / 100;

        emit(
          state.copyWith(
            expression: percentValue.toString(),
            result: percentValue,
            showResult: true,
            firstNum: percentValue.toString(),
            secondNum: null,
            operator: null,
          ),
        );
        return;
      }

      final regex = RegExp(r'(-?\d+\.?\d*)$');
      final match = regex.firstMatch(state.expression);

      if (match != null) {
        String current = match.group(0)!;
        double value = double.parse(current);

        if (state.firstNum != null && state.operator != null) {
          double num1 = double.parse(state.firstNum!);
          double percentValue = value / 100;
          double res = 0;

          switch (state.operator) {
            case '+':
              res = num1 + (num1 * percentValue);
              break;
            case '-':
              res = num1 - (num1 * percentValue);
              break;
            case 'X':
            case '*':
              res = num1 * percentValue;
              break;
            case '÷':
            case '/':
              if (percentValue == 0) {
                emit(
                  state.copyWith(
                    expression: "can't divide by zero",
                    result: 0,
                    showResult: true,
                    firstNum: null,
                    secondNum: null,
                    operator: null,
                  ),
                );
                return;
              }
              res = num1 / percentValue;
              break;
          }

          emit(
            state.copyWith(
              result: res,
              expression: res.toString(),
              showResult: true,
              firstNum: res.toString(),
              secondNum: null,
              operator: null,
            ),
          );
        } else if (state.firstNum != null &&
            state.secondNum != null &&
            state.operator != null) {
          double num1 = double.parse(state.firstNum!);
          double num2 = double.parse(state.secondNum!);
          double res = 0;

          switch (state.operator) {
            case '+':
              res = num1 + num2;
              break;
            case '-':
              res = num1 - num2;
              break;
            case 'X':
            case '*':
              res = num1 * num2;
              break;
            case '÷':
            case '/':
              if (num2 == 0) {
                emit(
                  state.copyWith(
                    expression: "can't divide by zero",
                    result: 0,
                    showResult: true,
                    firstNum: null,
                    secondNum: null,
                    operator: null,
                  ),
                );
                return;
              }
              res = num1 / num2;
              break;
          }

          double percentValue = res / 100;
          emit(
            state.copyWith(
              expression: percentValue.toString(),
              result: percentValue,
              showResult: true,
              firstNum: percentValue.toString(),
              secondNum: null,
              operator: null,
            ),
          );
        } else {
          double percentValue = value / 100;
          String newExpression =
              state.expression.substring(0, match.start) +
              percentValue.toString();

          emit(
            state.copyWith(
              expression: newExpression,
              result: percentValue,
              showResult: true,
              firstNum: percentValue.toString(),
              secondNum: null,
              operator: null,
            ),
          );
        }
      }
    } catch (e) {
      emit(
        state.copyWith(
          expression: "Error",
          result: 0,
          showResult: true,
          firstNum: null,
          secondNum: null,
          operator: null,
        ),
      );
    }
  }

  ///////
  void toggleSign() {
    if (state.operator == null && state.firstNum != null) {
      String current = state.firstNum!;
      String newValue;
      if (current.startsWith("-")) {
        newValue = current.substring(1);
      } else {
        newValue = "-$current";
      }
      String newExpression = state.expression;
      newExpression =
          newExpression.substring(0, newExpression.length - current.length) +
          newValue;

      emit(
        state.copyWith(
          firstNum: newValue,
          expression: newExpression,
          showResult: false,
        ),
      );
    } else if (state.operator != null && state.secondNum != null) {
      final regex = RegExp(r'(-?\d+\.?\d*)$');
      final match = regex.firstMatch(state.expression);

      if (match != null) {
        String current = match.group(0)!;
        String newValue = current.startsWith("-")
            ? current.substring(1)
            : "-$current";

        String newExpression =
            state.expression.substring(0, match.start) + newValue;

        emit(
          state.copyWith(
            secondNum: newValue,
            expression: newExpression,
            showResult: false,
          ),
        );
      }
    }
    else{
          emit(
          state.copyWith(
            
            expression: "Enter any number first",
           
          ),
        );
    }
  }

  void clear() {
    emit(const CalculatorState());
  }
}
