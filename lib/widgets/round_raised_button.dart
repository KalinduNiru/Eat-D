import 'package:flutter/material.dart';

class RoundRaisedButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final Function onTap;

  const RoundRaisedButton(
      {Key key,
      @required this.text,
      @required this.bgColor,
      @required this.textColor,
      this.borderColor,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          elevation: 1,
          textColor: textColor,
          color: bgColor,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: borderColor ?? bgColor),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
          onPressed: onTap,
        ),
      ),
    );
  }
}
