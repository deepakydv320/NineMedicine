import 'package:flutter/material.dart';

class ManagePatientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Patients', style: TextStyle(fontSize: 24)),
        backgroundColor: Color(0xFF68B0AB),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView( // Added to prevent overflow
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section with a button to add a new patient
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Patients',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E4E56),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add new patient logic
                  },
                  icon: Icon(Icons.person_add, size: 24),
                  label: Text('Add Patient'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Color(0xFF5DA3FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    shadowColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true, // Prevents the list from overflowing
              physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
              itemCount: 5, // Number of patients
              itemBuilder: (context, index) {
                return buildPatientCard(context, index);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new patient action
        },
        backgroundColor: Color(0xFF5DA3FA),
        child: Icon(Icons.add, size: 30, color: Colors.white),
        elevation: 10,
      ),
    );
  }

  // Widget for each patient card
  Widget buildPatientCard(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      shadowColor: Colors.black26,
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xFFE0F7FA),
              child: Icon(
                Icons.person,
                size: 35,
                color: Color(0xFF68B0AB),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patient Name', // Dynamic data can be added here
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E4E56),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Age: 30 | ID: #${index + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Last Visit: 10 Sep 2024',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.edit, color: Color(0xFF5DA3FA)),
              onPressed: () {
                // Edit patient logic
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                // Delete patient logic
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: ManagePatientsPage(),
));
