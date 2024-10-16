import 'package:flutter/material.dart';

void main() {
  runApp(HealthArticlesApp());
}

class HealthArticlesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Articles',
      debugShowCheckedModeBanner: false, // Debug banner हटाने के लिए
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HealthArticlesHomePage(),
    );
  }
}

class HealthArticlesHomePage extends StatefulWidget {
  @override
  _HealthArticlesHomePageState createState() => _HealthArticlesHomePageState();
}

class _HealthArticlesHomePageState extends State<HealthArticlesHomePage> {
  String selectedCategory = 'All'; // Dropdown Menu के लिए डिफ़ॉल्ट श्रेणी

  // List of articles with a category
  final List<Map<String, String>> articles = [
    {
      'title': 'Nutrition Tips for a Healthy Lifestyle',
      'subtitle': 'Learn about the best foods to maintain a healthy diet and boost your immune system.',
      'category': 'Nutrition',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Top 5 Exercises for a Strong Body',
      'subtitle': 'Discover simple yet effective workouts you can do at home or in the gym to build strength.',
      'category': 'Fitness',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Mental Health: Coping with Stress',
      'subtitle': 'Stress can impact your mental and physical health. Find out ways to manage and reduce stress.',
      'category': 'Mental Health',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Understanding Common Diseases and Prevention',
      'subtitle': 'Get informed about common diseases, their symptoms, and how you can prevent them.',
      'category': 'Diseases',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Articles'),
        centerTitle: true,
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            items: <String>['All', 'Nutrition', 'Fitness', 'Mental Health', 'Diseases']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: articles
            .where((article) =>
        selectedCategory == 'All' ||
            article['category'] == selectedCategory)
            .map((article) {
          return _buildArticleCard(
            article['title']!,
            article['subtitle']!,
            article['image']!,
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '© 2024 Health Articles | Stay Informed, Stay Healthy',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // Function to build each article card
  Widget _buildArticleCard(String title, String subtitle, String imageUrl) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailPage(title, subtitle, imageUrl),
            ),
          );
        },
        child: Column(
          children: [
            Hero(
              tag: title,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.png', // Placeholder image in assets
                image: imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(subtitle),
              ),
              leading: Icon(
                Icons.health_and_safety,
                color: Colors.green,
                size: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Detail page for each article
class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  ArticleDetailPage(this.title, this.subtitle, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: title,
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              subtitle,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
