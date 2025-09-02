import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateVehiclePage extends StatefulWidget {
  final String vehicleNumber;

  UpdateVehiclePage({required this.vehicleNumber});

  @override
  _UpdateVehiclePageState createState() => _UpdateVehiclePageState();
}

class _UpdateVehiclePageState extends State<UpdateVehiclePage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? vehicleData;
  bool loading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dlNumberController = TextEditingController();
  final TextEditingController _dlExpDateController = TextEditingController();
  final TextEditingController _insuranceExpDateController =
      TextEditingController();
  final TextEditingController _rcExpDateController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _passExpDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVehicleData(widget.vehicleNumber);
  }

  Future<void> fetchVehicleData(String vehicleNumber) async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(vehicleNumber)
        .get();
    if (doc.exists) {
      vehicleData = doc.data() as Map<String, dynamic>;
      _nameController.text = vehicleData!['Name'];
      _mobileController.text = vehicleData!['Mobile'];
      _addressController.text = vehicleData!['Add'];
      _dlNumberController.text = vehicleData!['DL no'];
      _dlExpDateController.text =
          (vehicleData!['DL exp date'] as Timestamp).toDate().toString();
      _insuranceExpDateController.text =
          (vehicleData!['Insurance exp date'] as Timestamp).toDate().toString();
      _rcExpDateController.text =
          (vehicleData!['RC exp date'] as Timestamp).toDate().toString();
      _issueDateController.text =
          (vehicleData!['issue date'] as Timestamp).toDate().toString();
      _passExpDateController.text =
          (vehicleData!['pass exp date'] as Timestamp).toDate().toString();
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> updateVehicleData() async {
    if (_formKey.currentState!.validate()) {
      final String vehicleNumber = widget.vehicleNumber;
      final String name = _nameController.text;
      final String mobile = _mobileController.text;
      final String address = _addressController.text;
      final String dlNumber = _dlNumberController.text;
      final DateTime dlExpDate = DateTime.parse(_dlExpDateController.text);
      final DateTime insuranceExpDate =
          DateTime.parse(_insuranceExpDateController.text);
      final DateTime rcExpDate = DateTime.parse(_rcExpDateController.text);
      final DateTime issueDate = DateTime.parse(_issueDateController.text);
      final DateTime passExpDate = DateTime.parse(_passExpDateController.text);

      await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(vehicleNumber)
          .update({
        'Name': name,
        'Mobile': mobile,
        'Add': address,
        'DL no': dlNumber,
        'DL exp date': Timestamp.fromDate(dlExpDate),
        'Insurance exp date': Timestamp.fromDate(insuranceExpDate),
        'RC exp date': Timestamp.fromDate(rcExpDate),
        'issue date': Timestamp.fromDate(issueDate),
        'pass exp date': Timestamp.fromDate(passExpDate),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicle data updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Vehicle Data'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(labelText: 'Mobile'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the mobile number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _dlNumberController,
                      decoration: InputDecoration(labelText: 'DL Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the DL number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _dlExpDateController,
                      decoration: InputDecoration(
                          labelText: 'DL Expiry Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the DL expiry date';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _insuranceExpDateController,
                      decoration: InputDecoration(
                          labelText: 'Insurance Expiry Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the insurance expiry date';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _rcExpDateController,
                      decoration: InputDecoration(
                          labelText: 'RC Expiry Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the RC expiry date';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _issueDateController,
                      decoration:
                          InputDecoration(labelText: 'Issue Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the issue date';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passExpDateController,
                      decoration: InputDecoration(
                          labelText: 'Pass Expiry Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the pass expiry date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: updateVehicleData,
                      child: Text('Update Vehicle Data'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
