/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _vehicleNumberController =
      TextEditingController();
  Map<String, dynamic>? vehicleData;
  bool loading = false;

  // updateData() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   // try {
  //   //   await firestore.collection('vehicles').doc('KA01AA1234').set({
  //   //     "vehicleNumber": "KA01AA1234",
  //   //     "Name": "John Doe",
  //   //     "Mobile": "9876543210",
  //   //     "Add": "123 Main St, City A",
  //   //     "DL no": "DL123456",
  //   //     "DL exp date": Timestamp.fromDate(DateTime(2025, 12, 31)),
  //   //     "Insurance exp date": Timestamp.fromDate(DateTime(2024, 12, 31)),
  //   //     "RC exp date": Timestamp.fromDate(DateTime(2025, 12, 31)),
  //   //     "issue date": Timestamp.fromDate(DateTime(2022, 1, 15)),
  //   //     "pass exp date": Timestamp.fromDate(DateTime(2024, 12, 15))
  //   //   }).then((val) {
  //   //     print("KA01AA1234  ::  Done");
  //   //   });
  //   // } catch (e) {
  //   //   print('Error');
  //   // }
  //   List<Map<String, dynamic>> vehicleData = [
  //     {
  //       "vehicleNumber": "KA01AA1234",
  //       "Name": "John Doe",
  //       "Mobile": "9876543210",
  //       "Add": "123 Main St, City A",
  //       "DL no": "DL123456",
  //       "DL exp date": Timestamp.fromDate(DateTime(2025, 12, 31)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2024, 12, 31)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2025, 12, 31)),
  //       "issue date": Timestamp.fromDate(DateTime(2022, 1, 15)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2024, 12, 15))
  //     },
  //     {
  //       "vehicleNumber": "KA01BB5678",
  //       "Name": "Jane Smith",
  //       "Mobile": "9876543211",
  //       "Add": "456 Elm St, City B",
  //       "DL no": "DL123457",
  //       "DL exp date": Timestamp.fromDate(DateTime(2024, 6, 30)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2023, 6, 30)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2024, 6, 30)),
  //       "issue date": Timestamp.fromDate(DateTime(2021, 7, 20)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2023, 7, 20))
  //     },
  //     {
  //       "vehicleNumber": "KA01CC9101",
  //       "Name": "Mike Johnson",
  //       "Mobile": "9876543212",
  //       "Add": "789 Maple St, City C",
  //       "DL no": "DL123458",
  //       "DL exp date": Timestamp.fromDate(DateTime(2026, 3, 31)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2025, 3, 31)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2026, 3, 31)),
  //       "issue date": Timestamp.fromDate(DateTime(2023, 2, 10)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2025, 2, 10))
  //     },
  //     {
  //       "vehicleNumber": "KA01DD2345",
  //       "Name": "Sarah Brown",
  //       "Mobile": "9876543213",
  //       "Add": "321 Oak St, City D",
  //       "DL no": "DL123459",
  //       "DL exp date": Timestamp.fromDate(DateTime(2023, 11, 30)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2022, 11, 30)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2023, 11, 30)),
  //       "issue date": Timestamp.fromDate(DateTime(2020, 12, 25)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2022, 12, 25))
  //     },
  //     {
  //       "vehicleNumber": "KA01EE6789",
  //       "Name": "David Wilson",
  //       "Mobile": "9876543214",
  //       "Add": "654 Pine St, City E",
  //       "DL no": "DL123460",
  //       "DL exp date": Timestamp.fromDate(DateTime(2027, 9, 30)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2026, 9, 30)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2027, 9, 30)),
  //       "issue date": Timestamp.fromDate(DateTime(2024, 5, 5)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2026, 5, 5))
  //     },
  //     {
  //       "vehicleNumber": "KA01FF0123",
  //       "Name": "Emma Davis",
  //       "Mobile": "9876543215",
  //       "Add": "987 Cedar St, City F",
  //       "DL no": "DL123461",
  //       "DL exp date": Timestamp.fromDate(DateTime(2025, 8, 31)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2024, 8, 31)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2025, 8, 31)),
  //       "issue date": Timestamp.fromDate(DateTime(2022, 3, 15)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2024, 3, 15))
  //     },
  //     {
  //       "vehicleNumber": "KA01GG4567",
  //       "Name": "James Martinez",
  //       "Mobile": "9876543216",
  //       "Add": "123 Birch St, City G",
  //       "DL no": "DL123462",
  //       "DL exp date": Timestamp.fromDate(DateTime(2026, 7, 31)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2025, 7, 31)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2026, 7, 31)),
  //       "issue date": Timestamp.fromDate(DateTime(2023, 4, 20)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2025, 4, 20))
  //     },
  //     {
  //       "vehicleNumber": "KA01HH8910",
  //       "Name": "Laura Garcia",
  //       "Mobile": "9876543217",
  //       "Add": "456 Willow St, City H",
  //       "DL no": "DL123463",
  //       "DL exp date": Timestamp.fromDate(DateTime(2024, 4, 30)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2023, 4, 30)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2024, 4, 30)),
  //       "issue date": Timestamp.fromDate(DateTime(2021, 11, 10)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2023, 11, 10))
  //     },
  //     {
  //       "vehicleNumber": "KA01II2345",
  //       "Name": "Robert Miller",
  //       "Mobile": "9876543218",
  //       "Add": "789 Walnut St, City I",
  //       "DL no": "DL123464",
  //       "DL exp date": Timestamp.fromDate(DateTime(2025, 10, 31)),
  //       "Insurance exp date": Timestamp.fromDate(DateTime(2024, 10, 31)),
  //       "RC exp date": Timestamp.fromDate(DateTime(2025, 10, 31)),
  //       "issue date": Timestamp.fromDate(DateTime(2022, 6, 15)),
  //       "pass exp date": Timestamp.fromDate(DateTime(2024, 6, 15))
  //     },
      // {
      //   "vehicleNumber": "KA01JJ6789",
      //   "Name": "Maria Wilson",
      //   "Mobile": "9876543219",
      //   "Add": "321 Chestnut St, City J",
      //   "DL no": "DL123465",
      //   "DL exp date": Timestamp.fromDate(DateTime(2027, 12, 31)),
      //   "Insurance exp date": Timestamp.fromDate(DateTime(2026, 12, 31)),
      //   "RC exp date": Timestamp.fromDate(DateTime(2027, 12, 31)),
      //   "issue date": Timestamp.fromDate(DateTime(2024, 8, 25)),
      //   "pass exp date": Timestamp.fromDate(DateTime(2026, 8, 25))
      // }
  //   ];

  //   for (var vehicle in vehicleData) {
  //     await firestore
  //         .collection('vehicles')
  //         .doc(vehicle['vehicleNumber'])
  //         .set(vehicle)
  //         .whenComplete(() {
  //       print('Document ${vehicle['vehicleNumber']} added');
  //     });
  //   }

  //   print('All Vehicles data added successfully.');
  // }

  Future<void> fetchVehicleData(String vehicleNumber) async {
    setState(() {
      loading = true;
    });
    await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(vehicleNumber)
        .get()
        .then((value) {
      final data = value.data();
      if (data != null) {
        setState(() {
          vehicleData = data;
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
          vehicleData = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Pass Checker'),
      ),
      body: !loading
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _vehicleNumberController,
                    decoration: InputDecoration(
                      labelText: 'Enter Vehicle Number',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      fetchVehicleData(_vehicleNumberController.text);
                    },
                    child: Text('Check Pass Validity'),
                  ),
                  SizedBox(height: 16.0),
                  vehicleData != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(),
                            Text(
                                'Vehicle Number: ${vehicleData!['vehicleNumber']}'),
                            Text(
                                'Pass Validity: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['pass exp date'].toDate())}'),
                          ],
                        )
                      : Text('No data found for this vehicle number'),
                  SizedBox(height: 16.0),
                  vehicleData != null
                      ? Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${vehicleData!['Name']}'),
                              Text('Mobile: ${vehicleData!['Mobile']}'),
                              Text('Address: ${vehicleData!['Add']}'),
                              Text('DL Number: ${vehicleData!['DL no']}'),
                              Text(
                                  'DL Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['DL exp date'].toDate())}'),
                              Text(
                                  'Insurance Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['Insurance exp date'].toDate())}'),
                              Text(
                                  'RC Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['RC exp date'].toDate())}'),
                              Text(
                                  'Issue Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['issue date'].toDate())}'),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  // ElevatedButton(onPressed: updateData, child: Text('Update Data')),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _vehicleNumberController =
      TextEditingController();
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

  Map<String, dynamic>? vehicleData;
  bool loading = false;

  Future<void> fetchVehicleData(String vehicleNumber) async {
    setState(() {
      loading = true;
    });
    await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(vehicleNumber)
        .get()
        .then((value) {
      final data = value.data();
      if (data != null) {
        setState(() {
          vehicleData = data;
          loading = false;
          _nameController.text = data['Name'];
          _mobileController.text = data['Mobile'];
          _addressController.text = data['Add'];
          _dlNumberController.text = data['DL no'];
          _dlExpDateController.text =
              DateFormat('yyyy-MM-dd').format(data['DL exp date'].toDate());
          _insuranceExpDateController.text = DateFormat('yyyy-MM-dd')
              .format(data['Insurance exp date'].toDate());
          _rcExpDateController.text =
              DateFormat('yyyy-MM-dd').format(data['RC exp date'].toDate());
          _issueDateController.text =
              DateFormat('yyyy-MM-dd').format(data['issue date'].toDate());
          _passExpDateController.text =
              DateFormat('yyyy-MM-dd').format(data['pass exp date'].toDate());
        });
      } else {
        setState(() {
          loading = false;
          vehicleData = null;
        });
      }
    });
  }

  Future<void> insertVehicleData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('vehicles')
        .doc(_vehicleNumberController.text)
        .set({
      "vehicleNumber": _vehicleNumberController.text,
      "Name": _nameController.text,
      "Mobile": _mobileController.text,
      "Add": _addressController.text,
      "DL no": _dlNumberController.text,
      "DL exp date":
          Timestamp.fromDate(DateTime.parse(_dlExpDateController.text)),
      "Insurance exp date":
          Timestamp.fromDate(DateTime.parse(_insuranceExpDateController.text)),
      "RC exp date":
          Timestamp.fromDate(DateTime.parse(_rcExpDateController.text)),
      "issue date":
          Timestamp.fromDate(DateTime.parse(_issueDateController.text)),
      "pass exp date":
          Timestamp.fromDate(DateTime.parse(_passExpDateController.text))
    }).then((val) {
      print("${_vehicleNumberController.text} added");
    });
  }

  Future<void> updateVehicleData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('vehicles')
        .doc(_vehicleNumberController.text)
        .update({
      "Name": _nameController.text,
      "Mobile": _mobileController.text,
      "Add": _addressController.text,
      "DL no": _dlNumberController.text,
      "DL exp date":
          Timestamp.fromDate(DateTime.parse(_dlExpDateController.text)),
      "Insurance exp date":
          Timestamp.fromDate(DateTime.parse(_insuranceExpDateController.text)),
      "RC exp date":
          Timestamp.fromDate(DateTime.parse(_rcExpDateController.text)),
      "issue date":
          Timestamp.fromDate(DateTime.parse(_issueDateController.text)),
      "pass exp date":
          Timestamp.fromDate(DateTime.parse(_passExpDateController.text))
    }).then((val) {
      print("${_vehicleNumberController.text} updated");
    });
  }

  Future<List<Map<String, dynamic>>> fetchExpiryList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    List<Map<String, dynamic>> vehicleList = [];
    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      vehicleList.add({
        "vehicleNumber": data["vehicleNumber"],
        "Name": data["Name"],
        "passExpDate":
            DateFormat('MMMM dd, yyyy').format(data["pass exp date"].toDate())
      });
    }
    return vehicleList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Pass Checker'),
      ),
      body: !loading
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _vehicleNumberController,
                      decoration: InputDecoration(
                        labelText: 'Enter Vehicle Number',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        fetchVehicleData(_vehicleNumberController.text);
                      },
                      child: Text('Check Pass Validity'),
                    ),
                    SizedBox(height: 16.0),
                    vehicleData != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Row(),
                              Text(
                                  'Vehicle Number: ${vehicleData!['vehicleNumber']}'),
                              Text(
                                  'Pass Validity: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['pass exp date'].toDate())}'),
                            ],
                          )
                        : Text('No data found for this vehicle number'),
                    SizedBox(height: 16.0),
                    vehicleData != null
                        ? Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${vehicleData!['Name']}'),
                                Text('Mobile: ${vehicleData!['Mobile']}'),
                                Text('Address: ${vehicleData!['Add']}'),
                                Text('DL Number: ${vehicleData!['DL no']}'),
                                Text(
                                    'DL Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['DL exp date'].toDate())}'),
                                Text(
                                    'Insurance Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['Insurance exp date'].toDate())}'),
                                Text(
                                    'RC Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['RC exp date'].toDate())}'),
                                Text(
                                    'Issue Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['issue date'].toDate())}'),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        await insertVehicleData();
                      },
                      child: Text('Insert Data'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await updateVehicleData();
                      },
                      child: Text('Update Data'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        List<Map<String, dynamic>> expiryList =
                            await fetchExpiryList();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Pass Expiry List'),
                            content: SingleChildScrollView(
                              child: DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(label: Text('Vehicle Number')),
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Pass Expiry Date')),
                                ],
                                rows: expiryList.map((vehicle) {
                                  return DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(vehicle["vehicleNumber"])),
                                      DataCell(Text(vehicle["Name"])),
                                      DataCell(Text(vehicle["passExpDate"])),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Pass Expiry List'),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));
