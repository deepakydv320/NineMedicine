import 'package:flutter/material.dart';

class ReferAndEarnPage extends StatefulWidget {
  @override
  _ReferAndEarnPageState createState() => _ReferAndEarnPageState();
}

class _ReferAndEarnPageState extends State<ReferAndEarnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer and Earn", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 4,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Text(
                "Tell your friend about Truemeds to get ₹200",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal[50],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Your referral code",
                      style: TextStyle(fontSize: 16, color: Colors.teal[700]),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "YJ74IS9T",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[900]),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.copy, color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () {},
                child: Text("Refer a friend"),
              ),
            ),
            SizedBox(height: 32),
            Text(
              "How referral works",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 16),
            ReferralStep(
              step: "Step 1",
              description:
              "Invite your friends to join truemeds using your referral code.",
            ),
            ReferralStep(
              step: "Step 2",
              description:
              "They receive ₹200 in their TM rewards on successful registration.",
            ),
            ReferralStep(
              step: "Step 3",
              description:
              "You will earn ₹200 in your TM Rewards after their first order worth more than ₹500 is delivered.",
            ),
          ],
        ),
      ),
    );
  }
}

class ReferralStep extends StatelessWidget {
  final String step;
  final String description;

  ReferralStep({required this.step, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$step",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.teal[700]),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.teal[600]),
          ),
        ),
      ],
    );
  }
}
