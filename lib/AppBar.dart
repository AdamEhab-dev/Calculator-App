import 'package:calculator_proj/const.dart';
import 'package:flutter/material.dart';

class Calc_Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Calc_Appbar({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: switchValue == true
          ? backgroundColorBlack
          : backgroundColor,
      centerTitle: true,
      title: Text(
        "Calculator",
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: switchValue == true ? Orange : BlueColor,

          shadows: [
            Shadow(
              blurRadius: 5,
              offset: Offset(1, 1),
              color: switchValue == false ? Colors.grey : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
