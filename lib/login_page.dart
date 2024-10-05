import 'package:flutter/material.dart';
import 'package:ninemedicine/RegisterPage.dart';  // Assuming this is the correct import path

String? registeredEmail;
String? registeredPassword;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
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
            String email = _emailController.text;
            String password = _passwordController.text;

            // Check if email and password match the registered credentials
            if (email == registeredEmail && password == registeredPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login successful')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Invalid email or password')),
              );
            }
          },
          child: Text(
            'LOGIN',
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
          ),
        ),
      ],
    );
  }
}
