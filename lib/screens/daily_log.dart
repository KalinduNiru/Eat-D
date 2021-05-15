import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../constants/app_colors.dart';
import '../enum/gender_enum.dart';
import '../widgets/CustomDatePickerTextField.dart';
import '../utils/enum_util.dart';
import '../screens/auth/login_screen.dart';
import 'package:ediclus/models/history_item.dart';
import '../screens/home_screen.dart';

class DailyLogScreen extends StatefulWidget {
  static const routeName = '/dailylog';

  @override
  _DailyLogScreenState createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var storage = FirebaseStorage.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _addnote = TextEditingController();
  final _ratingController = TextEditingController(text: '3.0');
  DateTime date = new DateTime.now();
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Daily Posts");
  final note = "";
  List<HistoryItem> _dailylog = [
    HistoryItem(
      id: Uuid().v4(),
    )
  ];

  double _rating;
  int _ratingBarMode;

  bool _success;
  String _userEmail;

  void _register() {
    final user = _auth.currentUser;

    dbRef.child(Uuid().v4()).set({
      'userid': user.uid,
      'note': _addnote.text,
      'date': date.toString(),
      'rating': _ratingBarMode,
    }).then((res) {
      _success = false;
    });
  }

  void _home() {
    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  @override
  void dispose() {
    _addnote.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _ratingController;
    _rating;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Daily Log', style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _addnote,
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Add your Note',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 10.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Rate your mood'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _ratingBar(_ratingBarMode),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: RaisedButton(
                        elevation: 1,
                        textColor: Colors.white,
                        color: AppColors.primaryColor,
                        child: Text(
                          'Add Daily logging',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _register();
                            _addnote.clear();
                            await _home();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ratingBar(int mode) {
    return RatingBar.builder(
      initialRating: 3,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return Container();
        }
      },
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
