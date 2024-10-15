import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ninemedicine/login_page.dart';
import 'edit_profile.dart';
import 'my_orders.dart';


class ProfileHomePage extends StatefulWidget {
  @override
  _ProfileHomePageState createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  String userName = ''; // To hold user's name
  String userEmail = ''; // To hold user's email
  String profileImageUrl = ''; // To hold the URL of the profile image

  @override
  void initState() {
    super.initState();
    fetchUserProfile(); // Fetch user profile data from Firestore
  }

  // Fetch the user profile from Firestore
  Future<void> fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user

    if (user != null) {
      String userId = user.uid;

      // Fetch user data from Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('User').doc(userId).get();

      if (doc.exists) {
        print('User data: ${doc.data()}'); // Debugging statement to check data fetched
        setState(() {
          userName = doc['name'] ?? 'User'; // Fetch the user's name
          userEmail = doc['email'] ?? 'No email provided'; // Fetch the user's email
          profileImageUrl = doc['profileImage'] ?? ''; // Fetch the profile image URL
        });
      } else {
        print('User document does not exist');
      }
    } else {
      print('No user is signed in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildHeader(context),
            SizedBox(height: 20),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  // Header section with user's name, email, and profile image
  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueAccent,
            backgroundImage: profileImageUrl.isNotEmpty // Load the profile image if available
                ? NetworkImage(profileImageUrl)
                : null,
            child: profileImageUrl.isEmpty
                ? Icon(Icons.person, size: 40, color: Colors.white) // Default icon
                : null,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName.isNotEmpty ? userName : 'User', // Display user name or default
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                userEmail.isNotEmpty ? userEmail : 'No email provided', // Display user email
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Navigate to EditProfilePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FuturisticProfilePage(
                        firstName: userName, // Pass the user's first name
                        email: userEmail, // Pass the user's email
                        userId: '', // You can pass the user ID if needed
                      ),
                    ),
                  );
                },
                child: Row(  // Added Row for icon and text
                  children: [
                    Icon(Icons.edit, size: 18, color: Colors.blueAccent), // Edit icon
                    SizedBox(width: 5), // Space between icon and text
                    Text('Edit Profile'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // The list of menu items
  Widget buildMenuItems(BuildContext context) {  // Pass context as parameter
    return Column(
      children: [
        buildMenuItem(
          icon: Icons.shopping_bag,
          title: 'My Orders',
          onTap: () {
            // Navigate to MyOrdersPage when "My Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyOrdersPage()), // Navigates to MyOrdersPage
            );
          },
        ),
        buildMenuItem(
          icon: Icons.account_balance_wallet,
          title: 'TM Wallet',
          onTap: () {
            // Handle TM Wallet tap
          },
        ),
        buildMenuItem(
          icon: Icons.people,
          title: 'Manage Patients',
          onTap: () {
            // Handle Manage Patients tap
          },
        ),
        buildMenuItem(
          icon: Icons.location_on,
          title: 'Manage Addresses',
          onTap: () {
            // Handle Manage Addresses tap
          },
        ),
        buildMenuItem(
          icon: Icons.monetization_on,
          title: 'Refer and Earn',
          onTap: () {
            // Handle Refer and Earn tap
          },
        ),
        buildMenuItem(
          icon: Icons.notifications,
          title: 'Reminder',
          onTap: () {
            // Handle Reminder tap
          },
        ),
        buildMenuItem(
          icon: Icons.article,
          title: 'Health Articles',
          onTap: () {
            // Handle Health Articles tap
          },
        ),
        buildMenuItem(
          icon: Icons.help_outline,
          title: 'Help',
          onTap: () {
            // Handle Help tap
          },
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen(),),
            );
          },
          child: Text(
            'Log out',
            style: TextStyle(color: Colors.red),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'v7.3.3', // App version number, change as needed
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // The reusable menu item builder
  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required void Function()? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
