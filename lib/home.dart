import 'package:calculator_proj/Buttons/Button_Blue_Orang.dart';
import 'package:calculator_proj/Buttons/Button_White_Black.dart';
import 'package:calculator_proj/conest.dart';
import 'package:calculator_proj/cubit/calculator_cubit.dart';
import 'package:calculator_proj/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCalculator extends StatefulWidget {
  const HomeCalculator({super.key});
  @override
  State<HomeCalculator> createState() => _HomeCalculatorState();
}

class _HomeCalculatorState extends State<HomeCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: switchValue == true
          ? backgroundColorBlack
          : backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CalculatorCubit, CalculatorState>(
          builder: (context, state) {
            final cubit = context.read<CalculatorCubit>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Switch(
                      activeColor: Orange,
                      inactiveTrackColor: ScreenColor,
                      activeTrackColor: const Color.fromARGB(255, 75, 75, 75),
                      inactiveThumbColor: BlueColor,
                      trackOutlineWidth:
                          WidgetStateProperty.resolveWith<double?>((
                            Set<WidgetState> states,
                          ) {
                            if (states.contains(WidgetState.disabled)) {
                              return 1;
                            }
                            return 0;
                          }),
                      value: switchValue,
                      onChanged: (value) {
                        setState(() {
                          switchValue = value;
                        });
                      },
                    ),
                  ],
                ),
                ///////////////
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: BlocBuilder<CalculatorCubit, CalculatorState>(
                    builder: (context, state) {
                      return ScreenNumpers(
                        Text1: state.expression.isEmpty
                            ? "0"
                            : state.expression,
                        Text2: state.result.toString(),
                      );
                    },
                  ),
                ),
                /////////
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonBlueOrang(
                        ButtonText: "AC",
                        CallBack: () => context.read<CalculatorCubit>().clear(),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "+/-",
                        CallBack: () =>
                            context.read<CalculatorCubit>().toggleSign(),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "%",
                        CallBack: () =>
                            context.read<CalculatorCubit>().applyPercentage(),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "÷",
                        CallBack: () =>
                            context.read<CalculatorCubit>().chooseOperator("÷"),
                      ),
                    ],
                  ),
                ),

                //
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWhiteBlack(
                        ButtonText: "7",
                        CallBack: () => cubit.enterNumber(7),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "8",
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(8),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "9",
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(9),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "X",
                        CallBack: () =>
                            context.read<CalculatorCubit>().chooseOperator("X"),
                      ),
                    ],
                  ),
                ),
                //
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWhiteBlack(
                        ButtonText: "4",
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(4),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "5",
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(5),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "6",
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(6),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "-",
                        CallBack: () =>
                            context.read<CalculatorCubit>().chooseOperator("-"),
                      ),
                    ],
                  ),
                ),
                //
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWhiteBlack(
                        ButtonText: "1",
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(1),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "2",
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(2),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "3",
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(3),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: "+",
                        CallBack: () =>
                            context.read<CalculatorCubit>().chooseOperator("+"),
                      ),
                    ],
                  ),
                ),
                //
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWhiteBlack(
                        ButtonText: "0",
                        flix: 2,
                        CallBack: () =>
                            context.read<CalculatorCubit>().enterNumber(0),
                      ),
                      ButtonWhiteBlack(
                        ButtonText: ".",
                        CallBack: () =>
                            context.read<CalculatorCubit>().addDecimalPoint(),
                      ),
                      ButtonBlueOrang(
                        ButtonText: "=",
                        CallBack: () =>
                            context.read<CalculatorCubit>().calculate(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
