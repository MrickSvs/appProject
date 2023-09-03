import 'package:flutter/material.dart';

class ShopDetailsModal extends StatelessWidget {
  final dynamic shopDetails;

  ShopDetailsModal({required this.shopDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            shopDetails['name'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(shopDetails['description']),
          SizedBox(height: 16),
          Text(
            'Style: ${shopDetails['style'].join(", ")}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Type: ${shopDetails['type'].join(", ")}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('Address: ${shopDetails['address']}'),
          Text('GPS Coordinates: ${shopDetails['gps']['coordinates'].join(", ")}'),
          SizedBox(height: 16),
          Image.network(shopDetails['imageUrl'], height: 150),
          SizedBox(height: 16),
          Text('Contact Email: ${shopDetails['contact']['email']}'),
          Text('Contact Phone: ${shopDetails['contact']['phone']}'),
          SizedBox(height: 16),
          Text('Opening Hours: ${shopDetails['openingHours']}'),
        ],
      ),
    );
  }
}
