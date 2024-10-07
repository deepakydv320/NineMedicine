import 'package:flutter/material.dart';

class FuturisticProfilePage extends StatefulWidget {
  @override
  _FuturisticProfilePageState createState() => _FuturisticProfilePageState();
}

class _FuturisticProfilePageState extends State<FuturisticProfilePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.cyanAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Avatar
               CircleAvatar(
                radius: 60,
                backgroundColor: Colors.cyanAccent,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),

              // First Name
              buildTextField('First Name', firstNameController),
              SizedBox(height: 15),

              // Last Name
              buildTextField('Last Name', lastNameController),
              SizedBox(height: 15),

              // Email
              buildTextField('Email ID', emailController, keyboardType: TextInputType.emailAddress),
              SizedBox(height: 15),

              // Mobile Number
              buildTextField('Mobile Number', mobileController, keyboardType: TextInputType.phone),
              SizedBox(height: 15),

              // Age
              buildTextField('Age', ageController, keyboardType: TextInputType.number),
              SizedBox(height: 15),

              // Gender Selection (as buttons)
              buildGenderSelection(),
              SizedBox(height: 30),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Profile saved');
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                  backgroundColor: Colors.cyanAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.cyanAccent,
                  elevation: 20,
                ),
                child: Text(
                  'Save Profile',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A reusable method to create a text field with the glowing futuristic style
  Widget buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.cyanAccent, fontSize: 16),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2), // Translucent background
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyanAccent),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyanAccent, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Gender selection as glowing buttons
  Widget buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: TextStyle(color: Colors.cyanAccent, fontSize: 16)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            futuristicButton('Male', gender == 'Male'),
            futuristicButton('Female', gender == 'Female'),
            futuristicButton('Other', gender == 'Other'),
          ],
        ),
      ],
    );
  }

  // Glowing button widget for gender selection
  Widget futuristicButton(String label, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          gender = label;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        backgroundColor: isSelected ? Colors.cyanAccent : Colors.transparent,
        side: BorderSide(color: Colors.cyanAccent, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadowColor: Colors.cyanAccent,
        elevation: isSelected ? 20 : 0,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.cyanAccent,
          fontSize: 16,
        ),
      ),
    );
  }
}
