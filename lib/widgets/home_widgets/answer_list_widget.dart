import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AnswerListWidget extends StatefulWidget {
  final int questionNo;
  final List<String> answerList;
  final Function(int, int) onAnswerSelected;
  final int selectedAnswer;

  const AnswerListWidget(
      {Key key,
      this.questionNo,
      this.answerList,
      this.onAnswerSelected,
      this.selectedAnswer})
      : super(key: key);

  @override
  _AnswerListWidgetState createState() => _AnswerListWidgetState();
}

class _AnswerListWidgetState extends State<AnswerListWidget> {

  void _onAnswerTapped(int answer) {
    if(widget.selectedAnswer != null) return;
    widget.onAnswerSelected(widget.questionNo, answer);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.answerList
            .asMap()
            .map((index, e) => MapEntry(
                index,
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 40),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => _onAnswerTapped(index),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: widget.selectedAnswer == null ||
                                              index == widget.selectedAnswer
                                          ? AppColors.primaryColor
                                          : Colors.grey,
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Text(
                                e,
                                style: TextStyle(
                                    color: widget.selectedAnswer == null ||
                                            index == widget.selectedAnswer
                                        ? AppColors.secondaryColor
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )))
            .values
            .toList(),
      ),
    );
  }
}
