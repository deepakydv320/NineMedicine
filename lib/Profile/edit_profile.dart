import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ninemedicine/Profile/P_homepage.dart';

class FuturisticProfilePage extends StatefulWidget {
  final String userId;

  FuturisticProfilePage({required this.userId, required String firstName, required String email});

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
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(widget.userId).get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        firstNameController.text = data['firstName'] ?? '';
        lastNameController.text = data['lastName'] ?? '';
        emailController.text = data['email'] ?? '';
        mobileController.text = data['mobile'] ?? '';
        ageController.text = data['age'] ?? '';
        gender = data['gender'];
        if (data['profileImage'] != null) {
          setState(() {
            _profileImage = File(data['profileImage']); // Optionally load the profile image
          });
        }
      }
    }
  }

  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Choose an option',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt, size: 40, color: Colors.cyanAccent),
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.photo, size: 40, color: Colors.cyanAccent),
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> uploadProfileImage(File image) async {
    String filePath = 'profile_images/${DateTime.now()}.png'; // Unique path
    try {
      await FirebaseStorage.instance.ref(filePath).putFile(image);
      return await FirebaseStorage.instance.ref(filePath).getDownloadURL(); // Return the download URL
    } catch (e) {
      print("Error uploading image: $e");
      return null; // Return null if there's an error
    }
  }

  Future<void> saveUserProfile(String firstName, String email, String lastName, String mobile, String age, String? gender) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = widget.userId; // Use passed user ID
      String? imageUrl;

      if (_profileImage != null) {
        imageUrl = await uploadProfileImage(_profileImage!); // Upload image and get URL
      }

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'firstName': firstName,
        'email': email,
        'lastName': lastName,
        'mobile': mobile,
        'age': age,
        'gender': gender,
        'profileImage': imageUrl, // Store image URL in Firestore
      }, SetOptions(merge: true));

      print('Profile saved successfully');
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
        backgroundColor: Colors.black,
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
              GestureDetector(
                onTap: _showImageSourceActionSheet,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.cyanAccent,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!) // Display selected image
                      : null,
                  child: _profileImage == null
                      ? Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.black,
                  )
                      : null,
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
                    // Get user input and save to Firestore
                    String firstName = firstNameController.text;
                    String email = emailController.text;
                    String lastName = lastNameController.text;
                    String mobile = mobileController.text;
                    String age = ageController.text;

                    // Save profile information
                    saveUserProfile(firstName, email, lastName, mobile, age, gender).then((_) {
                      // After successful save, navigate to the Accounts page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileHomePage()), // Pass userName if needed
                      );
                    });
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
