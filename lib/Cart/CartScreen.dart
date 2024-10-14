import 'package:flutter/material.dart';
import 'package:ninemedicine/Cart/DeleveryDetail.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _itemQuantity = 1;

  void _increaseQuantity() {
    setState(() {
      _itemQuantity++;
    });
  }

  void _decreaseQuantity() {
    if (_itemQuantity > 1) {
      setState(() {
        _itemQuantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CartItem(
              itemQuantity: _itemQuantity,
              increaseQuantity: _increaseQuantity,
              decreaseQuantity: _decreaseQuantity,
            ),
            SizedBox(height: 20),
            UploadPrescription(),
            SizedBox(height: 10),
            ApplyCoupon(),
            Spacer(),
            BottomSummary(),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final int itemQuantity;
  final VoidCallback increaseQuantity;
  final VoidCallback decreaseQuantity;

  CartItem({
    required this.itemQuantity,
    required this.increaseQuantity,
    required this.decreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                'https://via.placeholder.com/50', // Sample image
                width: 50,
                height: 50,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dolopar 650',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Aristo Pharmaceuticals Pvt.ltd'),
                  SizedBox(height: 5),
                  Text(
                    '₹115.00  18% OFF',
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  Text(
                    '₹94.30',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                  SizedBox(width: 5),
                  IconButton(
                      icon: Icon(Icons.remove), onPressed: decreaseQuantity),
                  Text('$itemQuantity'),
                  IconButton(
                      icon: Icon(Icons.add), onPressed: increaseQuantity),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '50.1% Cheaper Substitute Available',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class UploadPrescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle Upload Prescription
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.upload_file, color: Colors.blue),
            SizedBox(width: 10),
            Text(
              'Upload a Prescription',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplyCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle Apply Coupon
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.local_offer, color: Colors.blue),
            SizedBox(width: 10),
            Text(
              'Apply Coupon',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹133.64',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Handle View Bill
                },
                child: Text(
                  'View bill',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Deleverydetail(),
                  ));
            },
            child: Text('Add Delivery Details'),
          ),
        ],
      ),
    );
  }
}
