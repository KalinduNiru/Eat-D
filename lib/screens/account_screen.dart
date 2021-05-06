import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';
import '../constants/app_colors.dart';
import '../enum/gender_enum.dart';
import '../utils/enum_util.dart';
import '../widgets/CustomDatePickerTextField.dart';
import '../utils/goole_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/profile';

  final User _user = FirebaseAuth.instance.currentUser;
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final dbRef = FirebaseDatabase.instance.reference().child("Users");
  User _user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
   DateTime _selectedBirthDay;
   Gender _selectedGender;






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

  String _validateBirthDay(DateTime date) {
    if (date == null) return 'required';
    return null;
  }

  String _validateGender(Gender gender) {
    if (gender == null) return 'required';
    return null;
  }

  String _validateContactNo(String contactNo) {
    if (contactNo == null || contactNo.isEmpty) return 'required';
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState.validate()) {
      // perform api request
    }
  }

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  void printFirebase(){
    dbRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Your Profile', appBar: AppBar()),
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
                        child: Image.network(_user.photoURL),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Basic Information',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: "",
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
                        labelText: _user.displayName,
                      ),
                      validator: _validateUsername,
                    ),
                    TextFormField(
                      controller: _contactNoController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText:_user.email,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: _validateContactNo,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Password',
                      ),
                      validator: _validatePassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8),
                      child: RaisedButton(
                        elevation: 1,
                        textColor: Colors.white,
                        color: AppColors.primaryColor,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        onPressed: printFirebase,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Image.asset('assets/logos/logo-word.png'),
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
