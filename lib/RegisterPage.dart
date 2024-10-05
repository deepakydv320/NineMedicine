import 'package:flutter/material.dart';
import 'package:ninemedicine/login_page.dart';  // Assuming this is the correct import path

String? registeredEmail;
String? registeredPassword;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRegisterForm(),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already a member? ",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.black54),
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
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: [
        SizedBox(height: 13),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            backgroundColor: Colors.green.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            String name = _nameController.text;
            String email = _emailController.text;
            String phone = _phoneController.text;
            String password = _passwordController.text;

            if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && password.isNotEmpty) {
              // Store the email and password globally
              registeredEmail = email;
              registeredPassword = password;

              // Navigate to the login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            } else {
              // Show error message if fields are empty
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill in all fields')),
              );
            }
          },
          child: Text('REGISTER', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
