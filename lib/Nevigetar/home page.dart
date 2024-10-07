import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController(); // PageController added for PageView

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Choose your location',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your 6 digit Pin code',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Use your currents location',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.location_searching_sharp),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Text("Home"),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              onPressed: () => _showBottomSheet(context),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            tooltip: 'Wallet',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Cart',
            onPressed: () {},
          ),
        ],
      ),
      // Use ListView to allow the entire page to scroll, preventing bottom overflow
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for medicines',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: 12.0),
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              color: Colors.grey[200],
              child: Column(
                children: [
                  SizedBox(
                    height: 190,
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        buildImageCard('assets/stock-vector-various-meds-pills-capsules-blisters-glass-bottles-with-liquid-medicine-plastic-tubes-with-1409823341.jpg'),
                        buildImageCard('assets/0913-cmo-fdacongestant-lapook-2286432-640x360.jpg'),
                        buildImageCard('assets/1_032818060500.webp'),
                        buildImageCard('assets/images.jpg'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                  SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: 4, // Total number of pages (images)
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.blue, // Active dot color
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: const Text(
              "Shop by Category",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Horizontal scrollable row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildCategoryCard('Personal Care', 'assets/Personal-removebg-preview.png'),
                buildCategoryCard('Health Conditions', 'assets/tree.png'),
                buildCategoryCard('Diabetes Care', 'assets/tree.png'),
                buildCategoryCard('Vitamin & Supplement', 'assets/Personal-removebg-preview.png'),
                buildCategoryCard('Healthcare Devices', 'assets/dib.png'),
                buildCategoryCard('Sexual Wellness', 'assets/dib.png'),
                buildCategoryCard('Hair Care', 'assets/dib.png'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Additional card at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 6,
              child: SizedBox(
                height: 150,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images (2).jpg',
                        height: 150,
                        width: 280,
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildImageCard(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: 340,
          height: 190,
        ),
      ),
    );
  }

  Widget buildCategoryCard(String categoryName, String imagePath) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 6,
      child: SizedBox(
        width: 100,
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                categoryName,
                textAlign: TextAlign.center, // Center align text
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
