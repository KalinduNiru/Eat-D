import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../../constants/app_colors.dart';
import '../../enum/gender_enum.dart';
import '../../widgets/CustomDatePickerTextField.dart';
import '../../utils/enum_util.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';



  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  DateTime _selectedBirthDay;
  Gender _selectedGender;
  bool _success;
  String _userEmail;

  String _validateName(String name) {
    if (name == null || name.isEmpty) return 'required';
    return null;
  }

  String _validateUsername(String email) {
    if (email == null || email.isEmpty) return 'required';
    bool valid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!valid) return 'invalid format';
    return null;
  }

  String _validatePassword(String password) {
    if (password == null || password.isEmpty) return 'required';
    return null;
  }

  String _validateConfirmPassword(String password) {
    if (password == null || password.isEmpty) return 'required';
    if (password != _passwordController.text) return 'passwords should match';
    return null;
  }

  String _validateGender(Gender gender) {
    if (gender == null) return 'required';
    return null;
  }

  String _validateBirthDay(DateTime date) {
    if (date == null) return 'required';
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState.validate()) {
      // perform api request
    }
  }

  void _signInWithEmailAndPassword() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: _usernameController.text,
      password: _passwordController.text,
    )).user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  void _register() async {
    final User user = (await
    _auth.createUserWithEmailAndPassword(
      email: _usernameController.text,
      password: _passwordController.text,
    )
    ).user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up', style: TextStyle(color: Colors.black)),
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
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Name',
                      ),
                      validator: _validateName,
                    ),
                    CustomTextFieldDatePicker(
                      labelText: 'Date of Birth',
                      suffixIcon: Icon(Icons.calendar_today),
                      lastDate: DateTime.now(),
                      firstDate: DateTime(1960),
                      onDateChanged: (selectedDate) {
                        _selectedBirthDay = selectedDate;
                      },
                      validator: _validateBirthDay,
                    ),
                    FormField<Gender>(
                      builder: (FormFieldState<Gender> state) {
                        return Column(
                          children: [
                            InputDecorator(
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                labelText: 'Gender',
                              ),
                              isEmpty: _selectedGender == null,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Gender>(
                                  value: _selectedGender,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedGender = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: Gender.values.map((value) {
                                    return DropdownMenuItem<Gender>(
                                      value: value,
                                      child:
                                          Text(EnumUtil().enumToString(value)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: state.errorText == null
                                  ? Text("")
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(state.errorText,
                                          style: TextStyle(
                                              color: Colors.red[700],
                                              fontSize: 12)),
                                    ),
                            ),
                          ],
                        );
                      },
                      validator: _validateGender,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Email Address',
                      ),
                      validator: _validateUsername,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Password',
                      ),
                      validator: _validatePassword,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Confirm Password',
                      ),
                      validator: _validateConfirmPassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        elevation: 1,
                        textColor: Colors.white,
                        color: AppColors.primaryColor,
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        onPressed: _register,
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
}
