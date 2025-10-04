import 'package:calculator_proj/cubit/calculator_cubit.dart';
import 'package:calculator_proj/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyCalculator());
}

class MyCalculator extends StatelessWidget {
  const MyCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => CalculatorCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeCalculator(),
        ),
      ),
    );
  }
}
