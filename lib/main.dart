import 'package:flutter/material.dart';
import 'Profile/P_homepage.dart'; // Adjust the path to where your Profile page is located

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileHomePage(), // Call the correct class name here
    );
  }
}
