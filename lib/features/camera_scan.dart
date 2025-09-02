import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:intl/intl.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isBusy = false;
  final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer();
  String? recognizedText;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _scanText() async {
    if (isBusy) return;
    isBusy = true;

    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);

      final recognizedText = await _textRecognizer.processImage(inputImage);

      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          setState(() {
            this.recognizedText = line.text;
          });
        }
      }

      _fetchVehicleData();
    } catch (e) {
      print(e);
    } finally {
      isBusy = false;
    }
  }

  Future<void> _fetchVehicleData() async {
    if (recognizedText == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(recognizedText)
        .get();

    if (doc.exists) {
      Navigator.of(context).pop({
        'vehicleNumber': recognizedText,
        'data': doc.data(),
      });
    } else {
      Navigator.of(context).pop({'vehicleNumber': recognizedText, 'data': null});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Vehicle Number Plate'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      onPressed: _scanText,
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
