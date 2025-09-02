import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_pass_app/features/update_data.dart';

class ExpiredVehicleListPage extends StatefulWidget {
  @override
  _ExpiredVehicleListPageState createState() => _ExpiredVehicleListPageState();
}

class _ExpiredVehicleListPageState extends State<ExpiredVehicleListPage> {
  List<Map<String, dynamic>> expiredVehicles = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchExpiredVehicles();
  }

  Future<void> fetchExpiredVehicles() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    final DateTime now = DateTime.now();
    final List<Map<String, dynamic>> expired = [];

    querySnapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final Timestamp passExpDate = data['pass exp date'];
      final Timestamp dlExpDate = data['DL exp date'];
      final Timestamp insuranceExpDate = data['Insurance exp date'];
      final Timestamp rcExpDate = data['RC exp date'];

      if (passExpDate.toDate().isBefore(now) ||
          dlExpDate.toDate().isBefore(now) ||
          insuranceExpDate.toDate().isBefore(now) ||
          rcExpDate.toDate().isBefore(now)) {
        expired.add(data);
      }
    });

    setState(() {
      expiredVehicles = expired;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expired Vehicle List'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: expiredVehicles.length,
              itemBuilder: (context, index) {
                final vehicle = expiredVehicles[index];
                return ListTile(
                  title: Text(vehicle['vehicleNumber']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${vehicle['Name']}'),
                      Text('Mobile: ${vehicle['Mobile']}'),
                      Text('Address: ${vehicle['Add']}'),
                      Text(
                          'DL Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicle['DL exp date'].toDate())}'),
                      Text(
                          'Insurance Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicle['Insurance exp date'].toDate())}'),
                      Text(
                          'RC Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicle['RC exp date'].toDate())}'),
                      Text(
                          'Pass Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicle['pass exp date'].toDate())}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateVehiclePage(
                              vehicleNumber: vehicle['vehicleNumber']),
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
