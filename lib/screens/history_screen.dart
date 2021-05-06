import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/custom_appbar.dart';
import '../models/history_item.dart';
import '../constants/app_colors.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = '/history';
  User user = FirebaseAuth.instance.currentUser;

  final dbRef = FirebaseDatabase.instance.reference().child("Daily Posts");

  List<Map<dynamic, dynamic>> lists = [];
  final dateFormat = DateFormat('dd MMMM yyyy');
  final List<HistoryItem> historyItems = [
    HistoryItem(
      dateTime: DateTime.now().subtract(Duration(days: 1)),
      description: 'Talk with edisiuS about hunger',
    ),
    HistoryItem(
      dateTime: DateTime.now().subtract(Duration(days: 6)),
      description: 'Talk with edisiuS about hunger',
    ),
    HistoryItem(
      dateTime: DateTime.now().subtract(Duration(days: 8)),
      description: 'Talk with edisiuS about hunger',
    ),
    HistoryItem(
      dateTime: DateTime.now().subtract(Duration(days: 10)),
      description: 'Talk with edisiuS about hunger',
    ),
  ];

  bool isEdgeIndex(int index) {
    return index == user.uid;
  }

 /* @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(title: 'History', appBar: AppBar()),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.only(left: width / 8, right: 20, top: 20),
          child: FixedTimeline.tileBuilder(
            verticalDirection: VerticalDirection.up,
            theme: TimelineTheme.of(context).copyWith(
              color: AppColors.primaryColor,
              nodePosition: 0,
              connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                    thickness: 4.0,
                  ),
              indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                    size: 30.0,
                    position: 0.0,
                  ),
            ),
            builder: TimelineTileBuilder(
              indicatorBuilder: (_, index) => !isEdgeIndex(index)
                  ? Indicator.outlined(borderWidth: 2.0)
                  : null,
              startConnectorBuilder: (_, index) => Connector.solidLine(),
              endConnectorBuilder: (_, index) => Connector.solidLine(),
              contentsBuilder: (_, index) {
                if (isEdgeIndex(index)) {
                  return null;
                }

                return Padding(
                  padding: EdgeInsets.only(left: 8, top: 8, bottom: 40),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         lists[index]["date"],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.primaryColor, width: 1.4),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  lists[index]["note"],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                                child: Image.asset('assets/logos/logo.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              nodeItemOverlapBuilder: (_, index) =>
                  isEdgeIndex(index) ? true : null,
              itemCount: lists.length,
            ),
          ),
        ),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: CustomAppBar(title: 'History', appBar: AppBar()),
        body: FutureBuilder(
            future: dbRef.orderByChild('userid').equalTo(user.uid).once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData)  {
                lists.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  lists.add(values);
                });
                return new SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    padding: EdgeInsets.only(left: width / 8, right: 20, top: 20),
                    child: FixedTimeline.tileBuilder(
                      verticalDirection: VerticalDirection.up,
                      theme: TimelineTheme.of(context).copyWith(
                        color: AppColors.primaryColor,
                        nodePosition: 0,
                        connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                          thickness: 4.0
                        ),
                        indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                          size: 30.0,
                          position: 0.0,
                        ),
                      ),
                      builder: TimelineTileBuilder(
                        indicatorBuilder: (_, index) => !isEdgeIndex(index)
                            ? Indicator.outlined(borderWidth: 2.0,) :null,
                        startConnectorBuilder: (_, index) => Connector.solidLine(),
                        endConnectorBuilder: (_, index) => Connector.solidLine(),
                        contentsBuilder: (_, index) {
                          if(isEdgeIndex(index)){
                            return null;
                          }
                          return Padding(
                            padding: EdgeInsets.only(left: 8, top: 8, bottom: 40),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lists[index]["date"],
                                    style: TextStyle(
                                      fontSize: 14.0, fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: double.infinity,
                                    padding:EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 20),
                                    decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.primaryColor, width: 1.4),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            lists[index]["note"],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Image.asset('assets/logos/logo.png'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        nodeItemOverlapBuilder: (_, index) =>
                            isEdgeIndex(index) ? true :null,
                        itemCount: lists.length,

                      ),
                    ),
                  ),
                );
                /*ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Date: " + lists[index]["date"]),
                            Text("Note: " + lists[index]["note"]),

                          ],
                        ),
                      );
                    });*/
              }
              return CircularProgressIndicator();
            }));
  }
}
