import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String? userId;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      userId = user.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        setState(() {
          firstNameController.text = data['firstName'] ?? '';
          lastNameController.text = data['lastName'] ?? '';
          emailController.text = data['email'] ?? '';
          mobileController.text = data['mobile'] ?? '';
          ageController.text = data['age']?.toString() ?? '';
          gender = data['gender'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
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
              buildTextField('First Name', firstNameController),
              SizedBox(height: 15),
              buildTextField('Last Name', lastNameController),
              SizedBox(height: 15),
              buildTextField('Email ID', emailController, keyboardType: TextInputType.emailAddress),
              SizedBox(height: 15),
              buildTextField('Mobile Number', mobileController, keyboardType: TextInputType.phone),
              SizedBox(height: 15),
              buildTextField('Age', ageController, keyboardType: TextInputType.number),
              SizedBox(height: 15),
              buildGenderSelection(),
              SizedBox(height: 30),
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

  Widget buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.cyanAccent, fontSize: 16),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2),
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
