import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninemedicine/RegisterPage.dart';

import 'Nevigetar/nevigetar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                height: screenHeight * 0.25,
                width: screenHeight * 0.25,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.03,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLoginForm(screenHeight, screenWidth),
                      SizedBox(height: screenHeight * 0.03),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: Colors.black54),
                              ),
                              TextSpan(
                                text: "Register",
                                style: TextStyle(
                                  color: Colors.green.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(double screenHeight, double screenWidth) {
    return Column(
      children: [
        SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: screenWidth * 0.045),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.05,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(fontSize: screenWidth * 0.045),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.05,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Forgot password logic
            },
            child: Text(
              'Forgot Password?',
              style:
              TextStyle(color: Colors.black54, fontSize: screenWidth * 0.04),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.25,
              vertical: screenHeight * 0.02,
            ),
            backgroundColor: Colors.green.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            _loginUser();
          },
          child: Text(
            'LOGIN',
            style:
            TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
          ),
        ),
      ],
    );
  }

  Future<void> _loginUser() async {
    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If login is successful, navigate to the home page or dashboard
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Replace HomePage() with your home page widget
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = 'Login failed: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
