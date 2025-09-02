import 'package:flutter/material.dart';
import 'package:vehicle_pass_app/main.dart';
import 'package:intl/intl.dart';

class VehicleDetailsPage extends StatelessWidget {
  final Map<String, dynamic> vehicleData;

  VehicleDetailsPage({required this.vehicleData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Number: ${vehicleData['vehicleNumber']}',
              style: TextStyle(fontSize: 18),
            ),
            Text('Name: ${vehicleData['Name']}'),
            Text('Mobile: ${vehicleData['Mobile']}'),
            Text('Address: ${vehicleData['Add']}'),
            Text('DL Number: ${vehicleData['DL no']}'),
            Text(
                'DL Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData['DL exp date'].toDate())}'),
            Text(
                'Insurance Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData['Insurance exp date'].toDate())}'),
            Text(
                'RC Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData['RC exp date'].toDate())}'),
            Text(
                'Issue Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData['issue date'].toDate())}'),
            Text(
                'Pass Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData['pass exp date'].toDate())}'),
          ],
        ),
      ),
    );
  }
}
