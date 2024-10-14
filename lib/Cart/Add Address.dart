import 'package:flutter/material.dart';

class AddressFormScreen extends StatefulWidget {
  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController pincodeController = TextEditingController();

  // This would be used to get the location later using Geolocation
  void _getCurrentLocation() {
    // Add Geolocator functionality here to autofill Pincode
    setState(() {
      pincodeController.text = '123456'; // Example of autofilled Pincode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Pincode Field
              TextFormField(
                controller: pincodeController,
                decoration: InputDecoration(
                  labelText: 'Enter Pincode',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: _getCurrentLocation,
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),

              // House Number, Floor, Building Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'House number, Floor, Building name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),

              // Street, Locality, Area
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Street, Locality, Area',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),

              // Landmark (Optional)
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Landmark (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),

              // City and State in Row
              Row(
                children: <Widget>[
                  // City Field
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),

                  // State Dropdown Field
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'State',
                        border: OutlineInputBorder(),
                      ),
                      items: ['State 1', 'State 2', 'State 3']
                          .map((state) => DropdownMenuItem(
                        child: Text(state),
                        value: state,
                      ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Save As Buttons (Home, Office, Other)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ChoiceChip(
                    label: Text('Home'),
                    selected: false,
                  ),
                  ChoiceChip(
                    label: Text('Office'),
                    selected: false,
                  ),
                  ChoiceChip(
                    label: Text('Other'),
                    selected: false,
                  ),
                ],
              ),
              SizedBox(height: 24.0),

              // Save and Continue Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the form and proceed
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Address Saved')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Save and Continue',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}