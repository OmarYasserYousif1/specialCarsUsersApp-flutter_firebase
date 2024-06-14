import 'package:flutter/material.dart';
import 'package:users_app/pages/cars_details_page.dart';
import'package:users_app/models/car_model.dart';

class CarListPage extends StatelessWidget {
  final List<Car> cars = [
    Car(
      name: 'Toyota Camry',
      model: '2020',
      pricePerDay: 250,
      imageUrl: 'https://i0.wp.com/outmotorsports.com/wp-content/uploads/2020/01/DSC_6812.jpg?fit=1280%2C732&ssl=1',
    ),
    Car(
      name: 'Honda Accord',
      model: '2019',
      pricePerDay: 245,
      imageUrl: 'https://hips.hearstapps.com/hmg-prod/images/2018-honda-accord-hybrid-111-1529612531.jpg',
    ),
    Car(
      name: 'BMW 3 Series',
      model: '2021',
      pricePerDay: 500,
      imageUrl: 'https://images.ctfassets.net/c9t6u0qhbv9e/2021BMW3SeriesTestDriveReviewsummary/95042a4c746b62e17e8216d2c36ede20/2021_BMW_3_Series_Test_Drive_Review_summaryImage.jpeg',
    ),
    Car(
      name: 'Mercedes C Class',
      model: '2020',
      pricePerDay: 310,
      imageUrl: 'https://www.autotrader.ca/editorial/media/190424/2020-mercedes-benz-c-300-03-jm.jpg?width=1920&height=1080&v=1d6d29de644b810',
    ),
    Car(
      name: 'Audi A4',
      model: '2021',
      pricePerDay: 395,
      imageUrl: 'https://www.cnet.com/a/img/resize/5a655ac0a04a183ed508b586cec7a6d97e18f64d/hub/2021/01/14/20adf66d-e7c0-48a5-890b-594d571b44f4/a4-ogi.jpg?auto=webp&fit=crop&height=675&width=1200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent a special need car'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.network(car.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
              title: Text(car.name),
              subtitle: Text('${car.model}\nL.E ${car.pricePerDay}/day'),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailsPage(car: car),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
