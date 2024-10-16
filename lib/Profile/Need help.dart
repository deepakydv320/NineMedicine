import 'package:flutter/material.dart';

class NeedHelpPage extends StatelessWidget {
  const NeedHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Need help?'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for topic or question',
                prefixIcon: Container(
                  height: 30, // Height of the icon
                  child: Icon(Icons.search, color: Colors.blue),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildHelpTopic(context, Icons.medical_services, 'Medicine & Substitute Related', 4),
                  const Divider(height: 10.0, thickness: 0.0, color: Colors.grey),
                  buildHelpTopic(context, Icons.delivery_dining, 'Delivery', 10),
                  const Divider(height: 10.0, thickness: 0.0, color: Colors.grey),
                  buildHelpTopic(context, Icons.health_and_safety, 'Doctor Consultation', 4),
                  const Divider(height: 10.0, thickness: 0.0, color: Colors.grey),
                  buildHelpTopic(context, Icons.payment, 'Payment', 7),
                  const Divider(height: 10.0, thickness: 0.0, color: Colors.grey),
                  buildHelpTopic(context, Icons.card_giftcard, 'Return & Refunds', 6),
                  const Divider(height: 10.0, thickness: 0.0, color: Colors.grey),
                  buildHelpTopic(context, Icons.card_giftcard, 'Referrals', 6),
                  const Divider(height: 10.0, thickness: 0.0, color: Colors.grey),
                  buildHelpTopic(context, Icons.wallet, 'TM Wallet', 4),
                  const Divider(height: 10.0, thickness: 0.0, color: Colors.grey),
                  buildHelpTopic(context, Icons.help_outline, 'General Issues', 3),
                  const Divider(height: 10.0, thickness: 0.0, color: Colors.grey),
                ],
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // Action for customer support
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Still have questions? ',
                        style: TextStyle(color: Colors.black), // Color for the first part
                      ),
                      TextSpan(
                        text: 'Contact customer support',
                        style: TextStyle(color: Colors.blue), // Color for the second part
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create each help topic item with an icon and navigation
  Widget buildHelpTopic(BuildContext context, IconData icon, String title, int answerCount) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.0), // Reduced padding
      leading: Icon(icon, color: Colors.blueAccent), // Icon added here
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Align trailing icons to the right
        children: [
          Text('$answerCount Answers', style: TextStyle(color: Colors.grey)),
          SizedBox(width: 8), // Add some space between the answer count and the icon
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue), // Add the arrow icon
        ],
      ),
      onTap: () {
        // Navigate to the detail page on tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpDetailPage(title: title)),
        );
      },
    );
  }
}

// A simple Help Detail page
class HelpDetailPage extends StatelessWidget {
  final String title;

  const HelpDetailPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Details for $title',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
