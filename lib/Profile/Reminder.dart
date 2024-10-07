import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  List<Map<String, dynamic>> reminders = [];
  String reminderTitle = '';
  DateTime? reminderDate;

  void _addReminder() {
    if (reminderTitle.isNotEmpty && reminderDate != null) {
      setState(() {
        reminders.add({
          'title': reminderTitle,
          'date': reminderDate,
        });
        reminderTitle = '';
        reminderDate = null;
      });
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          reminderDate = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7), // Light background
      appBar: AppBar(
        title: Text(
          'Reminders',
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent, // Soft blue color for the app bar
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.lightBlueAccent.withOpacity(0.3), // Softer shadow
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reminder Title Input Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter reminder title',
                labelStyle: TextStyle(fontSize: 18, color: Colors.blueGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fillColor: Colors.lightBlueAccent.withOpacity(0.05),
                filled: true,
              ),
              style: TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  reminderTitle = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Date Picker Button
            ElevatedButton(
              onPressed: _pickDate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent, // Soft button color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2, // Reduced elevation
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    reminderDate == null ? 'Pick Date & Time' : _formatDate(reminderDate!),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Add Reminder Button
            Center(
              child: ElevatedButton(
                onPressed: _addReminder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Lighter green for add button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5, // Subtle elevation
                ),
                child: Text(
                  'Add Reminder',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Upcoming Reminders Section
            Text(
              'Upcoming Reminders',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey, // Softer text color
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: reminders.isEmpty
                  ? const Center(
                child: Text(
                  'No reminders added yet.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3, // Soft shadow
                    child: ListTile(
                      leading: Icon(Icons.notifications, color: Colors.lightBlueAccent),
                      title: Text(
                        reminders[index]['title'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _formatDate(reminders[index]['date']),
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          setState(() {
                            reminders.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: ReminderPage()));
