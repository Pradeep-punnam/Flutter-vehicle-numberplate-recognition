# 🚗 Vehicle Pass Management App

A Flutter-based mobile application for **vehicle number plate recognition** and **vehicle data management** using **Firebase Firestore** as backend.  
Supports **three roles**:  
- ADMIN 
- SUPERVISOR 
- SECURITY GUARD  

## ✨ Features
- Vehicle number plate scanning using camera + YOLO + OCR  
- Fetch vehicle details from Firestore  
- Add new vehicle records  
- Update existing vehicle records (restricted to Admin/Supervisor)  
- View expired vehicle passes  
- Role-based access control  

---

## 🔧 Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>=3.0.0)
- Dart (comes with Flutter)
- Firebase Account ([https://firebase.google.com](https://firebase.google.com))
- Android Studio / VS Code with Flutter extension
- A physical Android/iOS device or emulator

---

## 🔥 Firebase Setup

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Click **Add Project** → Enter project name → Continue.
3. Enable **Firestore Database** (Start in **Test Mode** for development).

### 2. Add Firebase to Flutter
1. In Firebase console, go to **Project Settings → Your Apps**.  
2. Register your app (choose **Android** and/or **iOS**).  
   - For Android: package name must match `applicationId` in `android/app/build.gradle`.  
   - For iOS: bundle ID must match Xcode project.  
3. Download the config files:
   - **Android** → `google-services.json` → place in `android/app/`
   - **iOS** → `GoogleService-Info.plist` → place in `ios/Runner/`
4. Add Firebase dependencies in your Flutter project:

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.27.0
  cloud_firestore: ^5.5.0
  firebase_auth: ^5.3.0
```
5. Run:
```bash
  flutter pub get
```
3. Initialize Firebase

Edit main.dart:
``` dart
   import 'package:flutter/material.dart';
   import 'package:firebase_core/firebase_core.dart';
   
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     runApp(const MyApp());
   }
```
🔒 Securing Firebase
Files you must not share publicly:
``` file
 google-services.json (Android)
```
``` file
 GoogleService-Info.plist (iOS)
```
Firebase API Keys inside these files

⚠️ If you share your repo, add these to .gitignore:
```files
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```
Best Practices:

Each developer should create their own Firebase project and add their own config files.

Enable Firestore Security Rules (see below).

🗄️ Firestore Database Schema

We use Firestore Collections as tables.

1. Vehicles Collection
```path
 vehicles (collection)
 └── vehicle_id (document ID)
       ├── vehicle_number: string
       ├── owner_name: string
       ├── owner_contact: string
       ├── vehicle_type: string
       ├── validity_start: timestamp
       ├── validity_end: timestamp
       └── created_by: string (admin/supervisor ID)
 ```
3. Users Collection
 ``` data
users (collection)
 └── user_id (document ID)
       ├── name: string
       ├── email: string
       ├── role: string ("ADMIN" | "SUPERVISOR" | "SECURITY_GUARD")
       └── created_at: timestamp
```
💻 Sample Code
Add Vehicle
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addVehicle(Map<String, dynamic> data) async {
  await FirebaseFirestore.instance.collection('vehicles').add(data);
}
```
Fetch Vehicle by Number
```dart
Future<Map<String, dynamic>?> getVehicle(String number) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('vehicles')
      .where('vehicle_number', isEqualTo: number)
      .limit(1)
      .get();

  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.data();
  }
  return null;
}
```
Update Vehicle
 ``` dart
Future<void> updateVehicle(String docId, Map<String, dynamic> data) async {
  await FirebaseFirestore.instance
      .collection('vehicles')
      .doc(docId)
      .update(data);
}
```
🔑 Firestore Security Rules

Example rules (only Admin & Supervisor can add/update vehicles):

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /vehicles/{vehicleId} {
      allow read: if request.auth != null;  // all logged in users can read
      allow write: if request.auth.token.role in ["ADMIN", "SUPERVISOR"];
    }
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}

🚀 Running the Project

1. Clone repo:
```bash
git clone https://github.com/your-username/vehicle-pass-app.git
cd vehicle-pass-app
```

2. Add your Firebase config files:
```file path
google-services.json → android/app/

GoogleService-Info.plist → ios/Runner/
```
3. Install dependencies:
```bash
flutter pub get
```

4. Run:
```bash
flutter run
```
📌 Notes

Each developer must set up their own Firebase project.

Do not share API keys or config files in public repos.

Configure Firestore indexes if needed (Firebase will prompt you in console when required).

📖 License

This project is licensed under the MIT License.


---

✅ This `README.md` now:  
- Explains **setup from scratch**.  
- Warns what to hide (`google-services.json`, API keys).  
- Shows **schema design** for vehicles & users.  
- Gives **ready-to-use Dart code**.  
- Includes **security rules** for role-based access.  
