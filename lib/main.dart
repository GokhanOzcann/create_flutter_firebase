import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(controller: controller,),
          actions: [IconButton(onPressed: () {
            final name = controller.text;

            createUser(name: name);
          }, icon: Icon(Icons.add))],
        ),
        
      ),
    );
  }
}

Future createUser({required String name}) async{
  final docUser = FirebaseFirestore.instance.collection('users').doc();

  final user = User(
    id: docUser.id,
    name: name,
    age:21,
    birthday: DateTime(2001, 7, 28),
  );
  final json = user.toJson();


  await docUser.set(json);
}

class User{
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id='',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name':name,
    'age':age,
    'birthday':birthday,

  };
}
