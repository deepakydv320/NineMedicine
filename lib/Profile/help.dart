 import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Need Help?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for topic or question',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Help Topics
            Expanded(
              child: ListView(
                children: [
                  _buildHelpTopic(Icons.medical_services_outlined, 'Medicine & Substitute Related', '4 Answers'),
                  _buildHelpTopic(Icons.local_shipping_outlined, 'Delivery', '10 Answers'),
                  _buildHelpTopic(Icons.local_hospital_outlined, 'Doctor Consultation', '4 Answers'),
                  _buildHelpTopic(Icons.payment_outlined, 'Payment', '7 Answers'),
                  _buildHelpTopic(Icons.assignment_return_outlined, 'Return & Refunds', '6 Answers'),
                  _buildHelpTopic(Icons.card_giftcard_outlined, 'Referrals', '6 Answers'),
                  _buildHelpTopic(Icons.account_balance_wallet_outlined, 'TM Wallet', '4 Answers'),
                  _buildHelpTopic(Icons.error_outline, 'General Issues', '3 Answers'),
                ],
              ),
            ),

            // Contact Support Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle support tap action
                  },
                  child: Text(
                    'Still have questions? Contact customer support',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build help topic list tiles
  Widget _buildHelpTopic(IconData icon, String title, String answersCount) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 28),
        title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        subtitle: Text(answersCount, style: TextStyle(color: Colors.grey[600])),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: () {
          // Handle the topic tap action
        },
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: HelpPage()));
