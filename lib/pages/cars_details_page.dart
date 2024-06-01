import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarDetailsPage extends StatefulWidget {
  final Car car;

  CarDetailsPage({required this.car});

  @override
  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final ValueNotifier<double> _totalPriceNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _daysController.addListener(_calculateTotalPrice);
    _firstNameController.addListener(_clearErrorMessages);
    _lastNameController.addListener(_clearErrorMessages);
    _addressController.addListener(_clearErrorMessages);
    _licenseController.addListener(_clearErrorMessages);
  }

  @override
  void dispose() {
    _daysController.removeListener(_calculateTotalPrice);
    _daysController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _licenseController.dispose();
    _totalPriceNotifier.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    final int? days = int.tryParse(_daysController.text);
    if (days != null && days > 0) {
      _totalPriceNotifier.value = days * widget.car.pricePerDay.toDouble();
    } else {
      _totalPriceNotifier.value = 0.0;
    }
  }

  void _clearErrorMessages() {
    if (_formKey.currentState != null) {
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.car.imageUrl),
            SizedBox(height: 16),
            Text(
              widget.car.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Model: ${widget.car.model}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Price per day: L.E ${widget.car.pricePerDay}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Text(
              'Fill in your details to rent this car:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _licenseController,
                    decoration: InputDecoration(
                      labelText: 'Driving License Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your driving license number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _daysController,
                    decoration: InputDecoration(
                      labelText: 'Number of Days',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of days';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ValueListenableBuilder<double>(
                    valueListenable: _totalPriceNotifier,
                    builder: (context, totalPrice, child) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Total Price',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                          text: 'L.E $totalPrice',
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Car {
  final String name;
  final String model;
  final int pricePerDay;
  final String imageUrl;

  Car({
    required this.name,
    required this.model,
    required this.pricePerDay,
    required this.imageUrl,
  });
}
