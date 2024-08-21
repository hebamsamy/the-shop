import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop/firebase_options.dart';
import 'package:shop/homeScreen.dart';
import 'package:shop/registerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, db) {
            if (db.connectionState == ConnectionState.done ||
                db.connectionState == ConnectionState.active) {
              return HomeScreen();
            } else {
              return Center(
                child: Text("Connection failed"),
              );
            }
          }),
routes: {
  "/register": (context)=> Registerscreen()
},
    );
  }
}
