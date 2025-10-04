import 'package:calculator_proj/conest.dart';
import 'package:flutter/material.dart';

class ButtonWhiteBlack extends StatelessWidget {
  ButtonWhiteBlack({
    super.key,
    required this.ButtonText,
    this.flix,
    required this.CallBack,
  });

  String ButtonText;
  final int? flix;
  final VoidCallback? CallBack;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flix ?? 1,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: switchValue == true
                  ? ButtonUpperShadowGreu
                  : ButtonUpperShadowWhite,
              blurRadius: 2,
              offset: Offset(-3, -3),
            ),
            BoxShadow(
              color: switchValue == true
                  ? ButtonLowerShadowBlack
                  : ButtonLowerShadowGrey,
              blurRadius: 2,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: CallBack,
          height: double.infinity,
          color: switchValue == true ? ButtonsColorBlack : ButtonsColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(9),
          ),
          elevation: 0,
          child: Text(
            '${ButtonText}',
            style: TextStyle(
              color: switchValue == true ? WhitekColorBlack : BlackColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

