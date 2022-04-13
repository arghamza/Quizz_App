import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizzapp/screens/login_screen.dart';
import 'package:quizzapp/screens/score_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBnUj3vh2OHlcKBHuU9RTBVhVUBNN-OAXw",
      appId: "1:699613043612:android:9b3b497ea4059e97024659",
      messagingSenderId: "699613043612",
      projectId: "quizzappflutte",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const login(),
    );
  }
}
