import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:math_expressions/math_expressions.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorState());

  void enterNumber(int number) {
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
            expression:
                state.expression + ".", 
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

      emit(
        state.copyWith(
          result: res,
          showResult: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          expression: "Error",
          result: 0,
          showResult: true,
        ),
      );
    }
  }

  /////////
  void applyPercentage() {
    if (state.firstNum != null &&
        state.secondNum != null &&
        state.operator != null) {
      double num1 = double.parse(state.firstNum!);
      double num2 = double.parse(state.secondNum!);
      double res = 0;
      if (state.operator == '+') {
        res = num1 + num2;
      } else if (state.operator == '-') {
        res = num1 - num2;
      } else if (state.operator == 'X') {
        res = num1 * num2;
      } else if (state.operator == '÷') {
        if (num2 == 0) {
          emit(
            state.copyWith(
              result: double.nan,
              showResult: true,
              firstNum: null,
              secondNum: null,
              operator: null,
            ),
          );
          return;
        } else {
          res = num1 / num2;
        }
      }

      emit(
        state.copyWith(
          result: res,
          showResult: true,
          firstNum: res.toString(),
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
      String current = state.secondNum!;
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
          secondNum: newValue,
          expression: newExpression,
          showResult: false,
        ),
      );
    }
  }

  void clear() {
    emit(const CalculatorState());
  }
}
