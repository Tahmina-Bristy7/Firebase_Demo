import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    upload();
  }

  Future upload() async {
    await Firebase.initializeApp();
    final collectionCreate =
        FirebaseFirestore.instance.collection('user').doc();
    await collectionCreate.set({'userName': 'Bristy'});
    final data1 = await http.get(Uri.parse(
        'https://www.shutterstock.com/image-illustration/3d-nature-water-animals-wallpaper-260nw-1615723393.jpg'));
    final imageBytes = data1.bodyBytes;
    final firebaseRef = FirebaseStorage.instance.ref();
    final storageName = firebaseRef.child("example.jpg");
    final uploadImage = storageName.putData(imageBytes);
    final storageName1 = firebaseRef.child("example2.jpg");
    final uploadImage1 = storageName.putData(imageBytes);
    final a = storageName.getData();
    print("object=====================$a");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Demo Apps"),
      ),
      body: const Center(child: Text("Uploaded")),
    );
  }
}
