import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/app_colors.dart';

class AIChatBot extends StatefulWidget {
  static const routeName = '/ai_chat';

  @override
  _AIChatBotState createState() => _AIChatBotState();
}

class _AIChatBotState extends State<AIChatBot> {
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  List<String> _data = [];

  static const String Bot_Url ="https://eatchatbot.herokuapp.com/bot";
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('EatD AI Assistant', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.iconColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Stack(
          children: <Widget>[
            AnimatedList(
              key: _listkey,
              initialItemCount: _data.length,
              itemBuilder: (BuildContext, int index, Animation animation) {
                return buildItem(_data[index], animation, index);
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: ColorFiltered(
                    colorFilter: ColorFilter.linearToSrgbGamma(),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.message,
                                  color: AppColors.primaryColor),
                              hintText: "Say Hi to EatD",
                              fillColor: Colors.white12),
                          controller: queryController,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (msg){
                            this.getResponse();
                          },
                        ),
                      ),
                    )))
          ],
        ));
  }

  void getResponse() {
    if (queryController.text.length > 0) {
      this.insertSingleItem(queryController.text);
      var client = getClient();
      try {
        client.post(
          Uri.parse(Bot_Url),
          body: {"query": queryController.text},
        )..then((response) {
            print(response.body);
            Map<String, dynamic> data = jsonDecode(response.body);
            insertSingleItem(data['response'] + "<bot>");
          });
      } finally {
        client.close();
        queryController.clear();
      }
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _listkey.currentState.insertItem(_data.length - 1);
  }

  http.Client getClient() {
    return http.Client();
  }
}

Widget buildItem(String item, Animation animation, int index) {
  bool mine = item.endsWith("<bot>");
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Bubble(
          child: Text(
            item.replaceAll("<bot", ""),
            style: TextStyle(color: mine ? Colors.white : Colors.black),
          ),
          padding: BubbleEdges.all(10),
        ),
      ),
    ),
  );
}
