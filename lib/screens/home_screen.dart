import 'package:after_layout/after_layout.dart';
import 'package:ediclus/screens/about_us.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants/app_colors.dart';
import '../models/question.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/home_list_item.dart';
import '../widgets/home_widgets/answer_list_widget.dart';
import '../widgets/home_widgets/question_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/blog_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeListItemModel {
  String text;
  List<String> answers;
  int type;
  int questionNo;
  int selectedAnswer;

  HomeListItemModel({this.text, this.answers, this.type, this.questionNo});

}

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  User _user = FirebaseAuth.instance.currentUser;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>

    with AfterLayoutMixin<HomeScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  User _user;
  final List<Question> questions = [
    Question(
        'Hi, I am EatD. How can I help you ?',
        [
          'I\'m feel Hungry',
          'What is EatD ?',
          'Connect with ChatBot',
          'Check Blog',
        ]),
    Question('How do you feel?', [
      'I\'m underweight',
      'I\'m overweight',
      'Nothing Special',
    ]),
    Question('How long has this been troubling?', [
      'Less than one day',
      'On day to on week',
      'One week to one month',
      'One month to one year',
      'More...',
    ]),
    Question('I am Searching your options.... Please hold with me', [
      'Okay Sure',
      'I can\'t wait',
      'I need a Doctor',
    ]),
  ];

  List<HomeListItemModel> _items = [];
  int _answeredQuestions = 0;

  @override
  void afterFirstLayout(BuildContext context) {
    _addQuestion1();
  }

  void _addQuestion1() async {
    Question question1 = questions[0];
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _items = []
      ..add(HomeListItemModel(text: question1.question, type: 0, questionNo: 1))
      ..addAll(_items);
    await Future.delayed(Duration(seconds: 2));

    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _items = []
      ..add(
          HomeListItemModel(answers: question1.answers, type: 1, questionNo: 1))
      ..addAll(_items);
  }

  void _addQuestion2() async {
    Question question2 = questions[1];
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _items = []
      ..add(HomeListItemModel(text: question2.question, type: 0, questionNo: 2))
      ..addAll(_items);
    await Future.delayed(Duration(seconds: 2));

    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _items = []
      ..add(
          HomeListItemModel(answers: question2.answers, type: 1, questionNo: 2))
      ..addAll(_items);
  }

  void _addQuestion3() async {
    Question question3 = questions[2];
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _items = []
      ..add(HomeListItemModel(text: question3.question, type: 0, questionNo: 3))
      ..addAll(_items);
    await Future.delayed(Duration(seconds: 2));

    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _items = []
      ..add(
          HomeListItemModel(answers: question3.answers, type: 1, questionNo: 3))
      ..addAll(_items);
  }

  void _addQuestion4() async {
    Question question4 = questions[3];
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _items = []
      ..add(HomeListItemModel(text: question4.question, type: 0, questionNo: 4))
      ..addAll(_items);
    await Future.delayed(Duration(seconds: 2));

    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _items = []
      ..add(
          HomeListItemModel(answers: question4.answers, type: 1, questionNo: 4))
      ..addAll(_items);
  }

  void _onAnswerTapped(int question, int answer) {
    switch (question) {
      case 1:
         _items[0].selectedAnswer = answer;
        setState(() {
          _answeredQuestions++;
          print("Test01");
        });
        _items[1].selectedAnswer = answer;
        setState(() {
          _answeredQuestions++;
          print("TestCase001");
        });
        _addQuestion2();
        break;
      case 2:
        _items[0].selectedAnswer = answer;
        setState(() {
          _answeredQuestions++;
          print("Test02");
        });
        _addQuestion3();
        break;
      case 3:
        _items[0].selectedAnswer = answer;
        setState(() {
          _answeredQuestions++;
        });
        _addQuestion4();
        break;
      default:
        _items[0].selectedAnswer = answer;
        setState(() {
          _answeredQuestions++;
        });
    }
  }

  void _openWhatisEat(){
    Navigator.pushNamedAndRemoveUntil(
        context, AboutUs.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 6),
            LinearPercentIndicator(
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 500,
              lineHeight: 6.0,
              percent: _answeredQuestions / questions.length,
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: AppColors.primaryColor,
            ),
            Expanded(
              child: Container(
                child: AnimatedList(
                    key: listKey,
                    reverse: true,
                    initialItemCount: _items.length,
                    itemBuilder: (context, index, animation) {
                      HomeListItemModel item = _items[index];
                      if (item.type == 0) {
                        return HomeListItem(
                          child: QuestionWidget(text: item.text),
                          animation: animation,
                        );
                      }
                      return HomeListItem(
                          child: AnswerListWidget(
                            answerList: item.answers,
                            questionNo: item.questionNo,
                            onAnswerSelected: _onAnswerTapped,
                            selectedAnswer: item.selectedAnswer,
                          ),
                          animation: animation);
                    }),
              ),
            ),
          ],
        ),
      ),
      endDrawer: CustomDrawer(
        onClose: () {
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.black26)),
        ),
        child: Row(
          children: [
            Container(child: Image.asset('assets/logos/logo-word.png'),),
            Spacer(),
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState.openEndDrawer();
                })
          ],
        ),
      ),
    );
  }
}
