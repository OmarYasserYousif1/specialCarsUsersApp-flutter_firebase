import 'package:flutter/material.dart';
import 'package:users_app/models/car_model.dart';

class CarDetailsPage extends StatefulWidget {
  final Car car;

  CarDetailsPage({required this.car});

  @override
  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _drivingLicenseController = TextEditingController();
  final TextEditingController _numberOfDaysController = TextEditingController();
  double _totalPrice = 0.0;

  void _updateTotalPrice() {
    int numberOfDays = int.tryParse(_numberOfDaysController.text) ?? 0;
    setState(() {
      _totalPrice = numberOfDays * widget.car.pricePerDay.toDouble();
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _drivingLicenseController.dispose();
    _numberOfDaysController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            color: Colors.pink[900],
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'We care about you',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Car Name: ${widget.car.name}'),
                Text('Model: ${widget.car.model}'),
                Text('Price per day: L.E ${widget.car.pricePerDay}'),
                Text('First Name: ${_firstNameController.text}'),
                Text('Last Name: ${_lastNameController.text}'),
                Text('Address: ${_addressController.text}'),
                Text('Driving License Number: ${_drivingLicenseController.text}'),
                Text('Number of Days: ${_numberOfDaysController.text}'),
                Text('Total Price: L.E $_totalPrice'),
              ],
            ),
          ),
          actions: [
            Container(
              color: Colors.pink[900],
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'One of our representatives will contact you ASAP to complete the procedures to receive the car.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.car.imageUrl),
              SizedBox(height: 16),
              Text(
                widget.car.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Model: ${widget.car.model}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Price per day: L.E ${widget.car.pricePerDay}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _drivingLicenseController,
                decoration: InputDecoration(labelText: 'Driving License Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your driving license number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberOfDaysController,
                decoration: InputDecoration(labelText: 'Number of Days'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of days';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _updateTotalPrice();
                },
              ),
              SizedBox(height: 8),
              Text(
                'Total Price: L.E $_totalPrice',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _showDialog();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
