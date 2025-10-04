import 'package:advanced_shadows/advanced_shadows.dart';
import 'package:calculator_proj/conest.dart';
import 'package:flutter/material.dart';

class ScreenNumpers extends StatefulWidget {
  ScreenNumpers({super.key, required this.Text1, required this.Text2});
  String Text1;
  String Text2;

  @override
  State<ScreenNumpers> createState() => _ScreenNumpersState();
}

class _ScreenNumpersState extends State<ScreenNumpers> {
  @override
  Widget build(BuildContext context) {
    return AdvancedShadow(
      innerShadows: [
        BoxShadow(
          color: switchValue == true ? ShadowBlock1 : ShadowWhite1,
          blurRadius: 5,
          offset: Offset(3, 3),
        ),
        BoxShadow(
          color: switchValue == true ? ShadowBlock2 : ShadowWhite2,
          blurRadius: 6,
          offset: Offset(-3, -3),
        ),
      ],
      outerShadows: [],
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: switchValue == true ? ScreenColorBlack : ScreenColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 7,
            right: 20,
            left: 20,
            top: 9,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.Text1,
                  style: TextStyle(
                    fontSize: 39,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.Text2,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 39,
                    fontWeight: FontWeight.bold,
                    color: switchValue == true ? Orange : BlueColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
