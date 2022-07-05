import 'package:ad_project/utils/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double fontSize;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = primartColor,
    this.fontSize = 30,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        widget.text,
        style: TextStyle(color: widget.textColor, fontSize: widget.fontSize),
      ),
      onPressed: widget.press,
      style: ElevatedButton.styleFrom(
          primary: widget.color,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: widget.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
    );
  }
}
