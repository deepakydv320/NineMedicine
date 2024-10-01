import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ninemedicine/RegisterPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _imageOpacity = 0.0;
  double _textOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _navigateToLogin();
  }

  _startAnimation() {
    // Delay the image fade-in
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _imageOpacity = 1.0;
      });
    });

    // Delay the text fade-in after the image
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        _textOpacity = 1.0;
      });
    });
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 5), () {

    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade900

        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              AnimatedOpacity(
                opacity: _imageOpacity,
                duration: Duration(seconds: 2),
                child: Image.asset(
                  'assets/logo.png',
                  height: 250,
                  width: 250,
                ),
              ),
              SizedBox(height: 20),


              AnimatedOpacity(
                opacity: _textOpacity,
                duration: Duration(seconds: 2),
                child: TweenAnimationBuilder(
                  tween: ColorTween(begin: Colors.white, end: Colors.yellow),
                  duration: Duration(seconds: 2), // Color transition duration
                  builder: (context, Color? color, _) {
                    return Text(
                      "9medicine",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Animated color effect
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
