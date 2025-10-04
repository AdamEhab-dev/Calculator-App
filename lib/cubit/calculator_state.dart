part of 'calculator_cubit.dart';

class CalculatorState extends Equatable {
  final String expression;  

  final num result;        
  final bool showResult;     
  final String? firstNum;
  final String? secondNum;
  final String? operator;  
  final bool? switchValueTheme;  

  const CalculatorState({
    this.expression = "",
    this.result = 0,
    this.showResult = false,
    this.firstNum,
    this.secondNum,
    this.operator,
    this.switchValueTheme = false,
  });

  CalculatorState copyWith({
    String? expression,
    double? result,
    bool? showResult,
    String? firstNum,
    String? secondNum,
    String? operator,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      showResult: showResult ?? this.showResult,
      firstNum: firstNum ?? this.firstNum,
      secondNum: secondNum ?? this.secondNum,
      operator: operator ?? this.operator,
    );
  }

  @override
  List<Object?> get props => [expression, result, showResult, firstNum, secondNum, operator];
}


