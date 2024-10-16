import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferAndEarnPage extends StatefulWidget {
  @override
  _ReferAndEarnPageState createState() => _ReferAndEarnPageState();
}

class _ReferAndEarnPageState extends State<ReferAndEarnPage> {
  String referralCode = "ABC123";
  bool isCopied = false;

  void _copyReferralCode() {
    Clipboard.setData(ClipboardData(text: referralCode)).then((_) {
      setState(() {
        isCopied = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isCopied = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refer & Earn', style: TextStyle(fontSize: 22, color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Referral Code Section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.tealAccent, Colors.teal]),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    "Your Referral Code",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  SizedBox(height: 10),
                  Text(
                    referralCode,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _copyReferralCode,
                    icon: Icon(isCopied ? Icons.check : Icons.copy, color: Colors.white),
                    label: Text(isCopied ? 'Copied' : 'Copy Code', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // How it Works Section
            _buildSectionTitle("How it Works"),
            _buildSteps(),
            SizedBox(height: 40),
            // FAQs Section
            _buildSectionTitle("FAQs"),
            _buildFAQ(),
            SizedBox(height: 40),
            // Terms and Conditions Section
            _buildSectionTitle("Terms and Conditions"),
            _buildTermsAndConditions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  Widget _buildSteps() {
    return Column(
      children: [
        _buildStep("1", "Share your referral code with friends."),
        _buildStep("2", "Your friend signs up using your code."),
        _buildStep("3", "Both of you earn rewards after their transaction."),
      ],
    );
  }

  Widget _buildStep(String number, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal,
            child: Text(number, style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 10),
          Expanded(child: Text(description)),
        ],
      ),
    );
  }

  Widget _buildFAQ() {
    return Column(
      children: [
        _buildFAQItem("How do I earn rewards?", "Earn rewards when your referred friend completes a transaction."),
        _buildFAQItem("Can I refer more than one friend?", "Yes, refer as many as you like."),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(answer),
        ],
      ),
    );
  }

  // Terms and Conditions Section
  Widget _buildTermsAndConditions() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "By participating in the referral program, you agree to the following terms:",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "1. Rewards are only provided when the referred person completes a qualifying transaction.",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            "2. Each user can refer multiple friends, but rewards are subject to the program’s limitations.",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            "3. The company reserves the right to suspend or terminate the referral program at any time.",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            "4. The referral code should only be shared with individuals who consent to receiving it.",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
