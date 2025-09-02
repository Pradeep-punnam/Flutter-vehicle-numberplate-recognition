import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vehicle_pass_app/features/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> vehicleData = [
    {
      "vehicleNumber": "KA01AA1234",
      "Name": "John Doe",
      "Mobile": "9876543210",
      "Add": "123 Main St, City A",
      "DL no": "DL123456",
      "DL exp date": Timestamp.fromDate(DateTime(2025, 12, 31)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2024, 12, 31)),
      "RC exp date": Timestamp.fromDate(DateTime(2025, 12, 31)),
      "issue date": Timestamp.fromDate(DateTime(2022, 1, 15)),
      "pass exp date": Timestamp.fromDate(DateTime(2024, 12, 15))
    },
    {
      "vehicleNumber": "KA01BB5678",
      "Name": "Jane Smith",
      "Mobile": "9876543211",
      "Add": "456 Elm St, City B",
      "DL no": "DL123457",
      "DL exp date": Timestamp.fromDate(DateTime(2024, 6, 30)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2023, 6, 30)),
      "RC exp date": Timestamp.fromDate(DateTime(2024, 6, 30)),
      "issue date": Timestamp.fromDate(DateTime(2021, 7, 20)),
      "pass exp date": Timestamp.fromDate(DateTime(2023, 7, 20))
    },
    {
      "vehicleNumber": "KA01CC9101",
      "Name": "Mike Johnson",
      "Mobile": "9876543212",
      "Add": "789 Maple St, City C",
      "DL no": "DL123458",
      "DL exp date": Timestamp.fromDate(DateTime(2026, 3, 31)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2025, 3, 31)),
      "RC exp date": Timestamp.fromDate(DateTime(2026, 3, 31)),
      "issue date": Timestamp.fromDate(DateTime(2023, 2, 10)),
      "pass exp date": Timestamp.fromDate(DateTime(2025, 2, 10))
    },
    {
      "vehicleNumber": "KA01DD2345",
      "Name": "Sarah Brown",
      "Mobile": "9876543213",
      "Add": "321 Oak St, City D",
      "DL no": "DL123459",
      "DL exp date": Timestamp.fromDate(DateTime(2023, 11, 30)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2022, 11, 30)),
      "RC exp date": Timestamp.fromDate(DateTime(2023, 11, 30)),
      "issue date": Timestamp.fromDate(DateTime(2020, 12, 25)),
      "pass exp date": Timestamp.fromDate(DateTime(2022, 12, 25))
    },
    {
      "vehicleNumber": "KA01EE6789",
      "Name": "David Wilson",
      "Mobile": "9876543214",
      "Add": "654 Pine St, City E",
      "DL no": "DL123460",
      "DL exp date": Timestamp.fromDate(DateTime(2027, 9, 30)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2026, 9, 30)),
      "RC exp date": Timestamp.fromDate(DateTime(2027, 9, 30)),
      "issue date": Timestamp.fromDate(DateTime(2024, 5, 5)),
      "pass exp date": Timestamp.fromDate(DateTime(2026, 5, 5))
    },
    {
      "vehicleNumber": "KA01FF0123",
      "Name": "Emma Davis",
      "Mobile": "9876543215",
      "Add": "987 Cedar St, City F",
      "DL no": "DL123461",
      "DL exp date": Timestamp.fromDate(DateTime(2025, 8, 31)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2024, 8, 31)),
      "RC exp date": Timestamp.fromDate(DateTime(2025, 8, 31)),
      "issue date": Timestamp.fromDate(DateTime(2022, 3, 15)),
      "pass exp date": Timestamp.fromDate(DateTime(2024, 3, 15))
    },
    {
      "vehicleNumber": "KA01GG4567",
      "Name": "James Martinez",
      "Mobile": "9876543216",
      "Add": "123 Birch St, City G",
      "DL no": "DL123462",
      "DL exp date": Timestamp.fromDate(DateTime(2026, 7, 31)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2025, 7, 31)),
      "RC exp date": Timestamp.fromDate(DateTime(2026, 7, 31)),
      "issue date": Timestamp.fromDate(DateTime(2023, 4, 20)),
      "pass exp date": Timestamp.fromDate(DateTime(2025, 4, 20))
    },
    {
      "vehicleNumber": "KA01HH8910",
      "Name": "Laura Garcia",
      "Mobile": "9876543217",
      "Add": "456 Willow St, City H",
      "DL no": "DL123463",
      "DL exp date": Timestamp.fromDate(DateTime(2024, 4, 30)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2023, 4, 30)),
      "RC exp date": Timestamp.fromDate(DateTime(2024, 4, 30)),
      "issue date": Timestamp.fromDate(DateTime(2021, 11, 10)),
      "pass exp date": Timestamp.fromDate(DateTime(2023, 11, 10))
    },
    {
      "vehicleNumber": "KA01II2345",
      "Name": "Robert Miller",
      "Mobile": "9876543218",
      "Add": "789 Walnut St, City I",
      "DL no": "DL123464",
      "DL exp date": Timestamp.fromDate(DateTime(2025, 10, 31)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2024, 10, 31)),
      "RC exp date": Timestamp.fromDate(DateTime(2025, 10, 31)),
      "issue date": Timestamp.fromDate(DateTime(2022, 6, 15)),
      "pass exp date": Timestamp.fromDate(DateTime(2024, 6, 15))
    },
    {
      "vehicleNumber": "KA01JJ6789",
      "Name": "Maria Wilson",
      "Mobile": "9876543219",
      "Add": "321 Chestnut St, City J",
      "DL no": "DL123465",
      "DL exp date": Timestamp.fromDate(DateTime(2027, 12, 31)),
      "Insurance exp date": Timestamp.fromDate(DateTime(2026, 12, 31)),
      "RC exp date": Timestamp.fromDate(DateTime(2027, 12, 31)),
      "issue date": Timestamp.fromDate(DateTime(2024, 8, 25)),
      "pass exp date": Timestamp.fromDate(DateTime(2026, 8, 25))
    }
  ];

  for (var vehicle in vehicleData) {
    await firestore
        .collection('vehicles')
        .doc(vehicle['vehicleNumber'])
        .set(vehicle)
        .whenComplete(() {
      print('Document ${vehicle['vehicleNumber']} added');
    });
  }

  print('All Vehicles data added successfully.');
}
