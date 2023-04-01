import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_lite/utility/myconstant.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  final Color textColor;
  final Icon? rightIcon;
  final Function()? rightButtonFn;
  final Icon? leftIcon;
  final Function()? leftButtonFn;
  final KeyboardTapCallback onKeyboardTap;
  final MainAxisAlignment mainAxisAlignment;

  const NumericKeyboard(
      {Key? key,
      required this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1', width, height),
              _calcButton('2', width, height),
              _calcButton('3', width, height),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('4', width, height),
              _calcButton('5', width, height),
              _calcButton('6', width, height),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('7', width, height),
              _calcButton('8', width, height),
              _calcButton('9', width, height),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: widget.leftButtonFn,
                child: Container(
                    alignment: Alignment.center,
                    width: width * 0.21,
                    height: height * 0.1,
                    child: widget.leftIcon),
              ),
              _calcButton('0', width, height),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.white,
                onTap: widget.rightButtonFn,
                child: Container(
                    alignment: Alignment.center,
                    width: width * 0.21,
                    height: height * 0.1,
                    child: widget.rightIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value, double width, double height) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      splashColor: Colors.white,
      onTap: () {
        // print(value.length);
        widget.onKeyboardTap(value);
      },
      child: Container(
        alignment: Alignment.center,
        width: width * 0.25,
        height: height * 0.1,
        child: Text(
          value,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 55,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
