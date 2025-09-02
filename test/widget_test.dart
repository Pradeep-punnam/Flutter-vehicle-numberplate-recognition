import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:vehicle_pass_app/main.dart';

void main() {
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Vehicle pass validity check', (WidgetTester tester) async {
    // Initialize a fake Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add sample data to the fake Firestore instance
    await FirebaseFirestore.instance.collection('vehicles').add({
      "vehicleNumber": "KA01AA1234",
      "Name": "John Doe",
      "Mobile": "9876543210",
      "Add": "123 Main St, City A",
      "DL no": "DL123456",
      "DL exp date": Timestamp.fromDate(DateTime(2025, 12, 31)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2024, 12, 31)),
      "RC exp date": Timestamp.fromDate(DateTime(2025, 12, 31)),
      "issue date": Timestamp.fromDate(DateTime(2022, 1, 15)),
      "pass exp date": Timestamp.fromDate(DateTime(2024, 12, 15)),
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the initial state of the UI
    expect(find.text('Vehicle Pass Checker'), findsOneWidget);
    expect(find.text('Enter Vehicle Number'), findsOneWidget);
    expect(find.text('Check Pass Validity'), findsOneWidget);

    // Enter a vehicle number
    await tester.enterText(find.byType(TextField), 'KA01AA1234');
    await tester.tap(find.text('Check Pass Validity'));
    await tester.pump();

    // Verify that the vehicle data is displayed
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Mobile'), findsOneWidget);
    expect(find.text('9876543210'), findsOneWidget);
  });
}
