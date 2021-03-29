import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String text;

  const QuestionWidget({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 10, left: 8, right: 8),
      padding: EdgeInsets.only(bottom: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Image.asset('assets/logos/logo.png'),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: width / 5),
            ],
          ),
        ],
      ),
    );
  }
}
