import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextFieldDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateFormat dateFormat;
  final FocusNode focusNode;
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final Function(DateTime) validator;

  CustomTextFieldDatePicker({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.dateFormat,
    this.initialDate,
    this.validator,
    @required this.lastDate,
    @required this.firstDate,
    @required this.onDateChanged,
  })  : assert(firstDate != null),
        assert(lastDate != null),
        assert(!(initialDate?.isBefore(firstDate) ?? false),
            'initialDate must be on or after firstDate'),
        assert(!(initialDate?.isAfter(lastDate) ?? false),
            'initialDate must be on or before lastDate'),
        assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate'),
        assert(onDateChanged != null, 'onDateChanged must not be null'),
        super(key: key);

  @override
  _MyTextFieldDatePicker createState() => _MyTextFieldDatePicker();
}

class _MyTextFieldDatePicker extends State<CustomTextFieldDatePicker> {
  TextEditingController _controllerDate;
  DateFormat _dateFormat;
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      _dateFormat = DateFormat.MMMEd();
    }

    _selectedDate = widget.initialDate;

    _controllerDate = TextEditingController();
    if (_selectedDate != null)
      _controllerDate.text = _dateFormat.format(_selectedDate);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _controllerDate.text = _dateFormat.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }

    if (widget.focusNode != null) {
      widget.focusNode.nextFocus();
    }
  }

  @override
  void dispose() {
    _controllerDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: _controllerDate,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
      validator: (_) {
        return widget.validator(_selectedDate);
      },
    );
  }
}
