import 'package:flutter/material.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  String _selectedOrderStatus = "All Orders";
  String _tempSelectedStatus = "All Orders"; // Initialize to default "All Orders"
  final List<String> _orderStatusOptions = [
    "All Orders",
    "Active",
    "Cancelled",
    "Delivered",
    "Returned",
  ];

  // Mock orders to display
  final List<Map<String, String>> _orders = [
    {
      "id": "123456",
      "status": "Delivered",
      "date": "Sep 28, 2024",
      "total": "\$250.00",
    },
    {
      "id": "654321",
      "status": "Active",
      "date": "Oct 01, 2024",
      "total": "\$120.00",
    }
  ];

  // Function to show the filter modal bottom sheet.
  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Filter Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Divider(),

                  ListTile(
                    title: Text('Order status'),
                    subtitle: Column(
                      children: _orderStatusOptions.map((status) {
                        return RadioListTile<String>(
                          title: Text(status),
                          value: status,
                          groupValue: _tempSelectedStatus,
                          onChanged: (value) {
                            setModalState(() {
                              _tempSelectedStatus = value!;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 20),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Clear Button
                      ElevatedButton(
                        onPressed: () {
                          setModalState(() {
                            _tempSelectedStatus = "All Orders";
                          });
                        },
                        child: Text("Clear"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedOrderStatus = _tempSelectedStatus;
                          });
                          Navigator.pop(context); // Close modal
                        },
                        child: Text("Apply"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search orders...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Order Card Widget
  Widget _buildOrderCard(Map<String, String> order) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order #${order['id']}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Text("Status: ${order['status']}"),
            SizedBox(height: 5),
            Text("Total: ${order['total']}"),
            SizedBox(height: 5),
            Text("Date: ${order['date']}"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle tracking or viewing order details
              },
              child: Text("View Details"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, User",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("Here are your recent orders"),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),

              // Search Bar
              _buildSearchBar(),

              // Filter Orders Section
              GestureDetector(
                onTap: () {
                  _showFilterModal(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedOrderStatus,
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Orders Section
              _orders.isNotEmpty
                  ? Column(
                children: _orders
                    .map((order) => _buildOrderCard(order))
                    .toList(),
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined,
                        size: 120, color: Colors.grey[400]),
                    SizedBox(height: 20),
                    Text(
                      'No $_selectedOrderStatus orders yet.',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600]),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle "Search for medicines" button press
                      },
                      child: Text('Search for medicines'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.greenAccent,
      scaffoldBackgroundColor: Colors.grey[100],
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontSize: 16),
      ),
    ),
    home: MyOrdersPage(),
  ));
}
