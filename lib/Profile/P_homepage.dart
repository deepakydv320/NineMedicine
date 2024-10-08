import 'package:flutter/material.dart';
import 'package:ninemedicine/login_page.dart';
import 'edit_profile.dart';
import 'my_orders.dart'; // Import the MyOrdersPage

class ProfileHomePage extends StatelessWidget {
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
            buildHeader(context),  // Pass context here
            SizedBox(height: 20),
            buildMenuItems(context),  // Pass context here
          ],
        ),
      ),
    );
  }

  // Header section with user's phone number and add details button
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
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '8651204362', // Example phone number, you can make it dynamic
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Navigate to EditProfilePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FuturisticProfilePage()), // \m-0
                    // nsure EditProfilePage is defined

                  );
                },
                child: Row(  // Added Row for icon and text
                  children: [
                    Icon(Icons.edit, size: 18, color: Colors.blueAccent), // Edit icon
                    SizedBox(width: 5), // Space between icon and text
                    Text('Add your details'),
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
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
