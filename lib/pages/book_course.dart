import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class MyFormPage extends StatefulWidget {
  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _ageController = TextEditingController();
  String _dropdownValue = 'Leg disability';
  String? _ageMessage;
  DateTime? _birthDateFromId;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _nationalIdController.dispose();
    _birthDateController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _resetFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _addressController.clear();
    _nationalIdController.clear();
    _birthDateController.clear();
    _ageController.clear();
    setState(() {
      _dropdownValue = 'Leg disability';
      _ageMessage = null;
      _birthDateFromId = null;
    });
  }

  void _showDialog(String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            color: Colors.pink.shade800,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'We care about you',
              style: TextStyle(color: Colors.white),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                color: Colors.pink.shade800,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'One of our specialists will contact you ASAP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetFields();
              },
            ),
          ],
        );
      },
    );
  }

  void _calculateAgeFromNationalId(String nationalId) {
    if (nationalId.length != 14) {
      setState(() {
        _ageMessage = 'Invalid ID length';
        _birthDateFromId = null;
        _birthDateController.clear();
        _ageController.clear();
      });
      return;
    }

    String centuryPrefix = nationalId[0] == '2' ? '19' : '20';
    String year = nationalId.substring(1, 3);
    String month = nationalId.substring(3, 5);
    String day = nationalId.substring(5, 7);

    String birthDateStr = '$centuryPrefix$year-$month-$day';
    DateTime birthDate = DateTime.parse(birthDateStr);
    _birthDateFromId = birthDate;

    _birthDateController.text = DateFormat('yyyy-MM-dd').format(birthDate);

    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    _ageController.text = age.toString();

    if (age < 18) {
      setState(() {
        _ageMessage = 'You are too young';
      });
    } else {
      setState(() {
        _ageMessage = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nationalIdController.addListener(() {
      if (_nationalIdController.text.length == 14) {
        _calculateAgeFromNationalId(_nationalIdController.text);
      } else {
        setState(() {
          _birthDateFromId = null;
          _birthDateController.clear();
          _ageController.clear();
        });
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _ageMessage == null) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String address = _addressController.text;
      String nationalId = _nationalIdController.text;
      String birthDate = _birthDateController.text;
      String age = _ageController.text;
      String disabilityType = _dropdownValue;

      String dialogText = 'First Name: $firstName\n'
          'Last Name: $lastName\n'
          'Address: $address\n'
          'National ID: $nationalId\n'
          'Date of Birth: $birthDate\n'
          'Age: $age\n'
          'Disability Type: $disabilityType';

      _showDialog(dialogText);
    }
  }

  void _clearValidationMessages() {
    setState(() {
      _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a driving course'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _clearValidationMessages();
                  },
                ),
                const SizedBox(height: 10.0,),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _clearValidationMessages();
                  },
                ),
                const SizedBox(height: 10.0,),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.home),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _clearValidationMessages();
                  },
                ),
                const SizedBox(height: 10.0,),
                TextFormField(
                  controller: _nationalIdController,
                  decoration: InputDecoration(
                    labelText: 'National ID',
                    prefixIcon: Icon(Icons.badge),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your National ID';
                    }
                    if (value.length != 14) {
                      return 'National ID must be 14 characters';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _clearValidationMessages();
                  },
                ),
                const SizedBox(height: 10.0,),
                TextFormField(
                  controller: _birthDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 10.0,),
                TextFormField(
                  controller: _ageController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    prefixIcon: Icon(Icons.cake),
                  ),
                ),
                const SizedBox(height: 10.0,),
                if (_ageMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _ageMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                DropdownButtonFormField<String>(
                  value: _dropdownValue,
                  decoration: InputDecoration(
                    labelText: 'Type of Disability',
                    prefixIcon: Icon(Icons.accessibility),
                  ),
                  items: <String>['Leg disability', 'Arm disability', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownValue = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
