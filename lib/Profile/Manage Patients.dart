import 'package:flutter/material.dart';


class ManagePatientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Patients'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add your back navigation logic here
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for patient cards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 80, color: Colors.grey[300]),
                SizedBox(width: 20),
                Icon(Icons.person_outline, size: 80, color: Colors.grey[300]),
                SizedBox(width: 20),
                Icon(Icons.person_outline, size: 80, color: Colors.grey[300]),
              ],
            ),
            SizedBox(height: 20),
            // "No patients yet" text
            Text(
              'No patients yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            // "Add new patients" button
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add new patients'),
              onPressed: () {
                // Add new patients logic here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
