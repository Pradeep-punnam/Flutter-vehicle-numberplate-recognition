import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_pass_app/features/camera_scan.dart';
import 'package:vehicle_pass_app/features/expired_list.dart';
import 'package:vehicle_pass_app/features/insert_page.dart';
import 'package:vehicle_pass_app/features/update_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _vehicleNumberController =
      TextEditingController();
  Map<String, dynamic>? vehicleData;
  bool loading = false;
  CameraController? _cameraController;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras != null && cameras!.isNotEmpty) {
        _cameraController = CameraController(
          cameras![0],
          ResolutionPreset.high,
        );
        _cameraController?.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> fetchVehicleData() async {
    setState(() {
      loading = true;
      vehicleData = null;
    });

    final String vehicleNumber = _vehicleNumberController.text;
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(vehicleNumber)
        .get();

    setState(() {
      vehicleData = doc.exists ? doc.data() as Map<String, dynamic> : null;
      loading = false;
    });
  }

  // Future<void> takePicture() async {
  //   if (!_cameraController!.value.isInitialized) {
  //     return;
  //   }

  //   if (_cameraController!.value.isTakingPicture) {
  //     return;
  //   }

  //   try {
  //     final image = await _cameraController!.takePicture();
  //     // Handle the captured image here
  //     print('Picture taken: ${image.path}');
  //   } catch (e) {
  //     print('Error taking picture: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Pass Validity Check'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _vehicleNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Vehicle Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: fetchVehicleData,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fetch Vehicle \nData',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        ElevatedButton(
                          onPressed: () {
                            if (vehicleData != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdateVehiclePage(
                                      vehicleNumber:
                                          vehicleData!['vehicleNumber']),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Update Vehicle\nData',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
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
                        : const Text('No data found for this vehicle number'),
                    const SizedBox(height: 16.0),
                    vehicleData != null
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Vehicle Number: ${vehicleData!['vehicleNumber']}'),
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
                                  Text(
                                      'Pass Expiry Date: ${DateFormat('MMMM dd, yyyy').format(vehicleData!['pass exp date'].toDate())}'),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddVehiclePage(),
                          ),
                        );
                      },
                      child: const Text('Add Vehicle Data'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ExpiredVehicleListPage(),
                          ),
                        );
                      },
                      child: const Text('View Expired Vehicle List'),
                    ),
                    const SizedBox(height: 16.0),
                    _cameraController == null &&
                            _cameraController!.value.isInitialized
                        ? ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CameraPage(),
                              ),
                            ),
                            child: const Text('Open Camera'),
                          )
                        : const Text('Camera not available'),
                  ],
                ),
              ),
            ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));
