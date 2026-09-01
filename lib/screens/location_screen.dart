import 'package:flutter/material.dart';

import '../main.dart';

/// Simple value returned when the user picks a location.
class LocationItem {
  final String city;
  final String country;

  const LocationItem(this.city, this.country);
}

/// Every city here has stays in kDummyProperties.
const List<LocationItem> _kLocations = <LocationItem>[
  LocationItem('Mumbai', 'India'),
  LocationItem('Delhi', 'India'),
  LocationItem('Goa', 'India'),
  LocationItem('Bangalore', 'India'),
  LocationItem('Manali', 'India'),
  LocationItem('Jaipur', 'India'),
  LocationItem('Udaipur', 'India'),
  LocationItem('Uttarakhand', 'India'),
  LocationItem('Lonavala', 'India'),
  LocationItem('Coorg', 'India'),
  LocationItem('Ooty', 'India'),
  LocationItem('Alibaug', 'India'),
];

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final String q = _query.trim().toLowerCase();
    final List<LocationItem> results = _kLocations
        .where((LocationItem l) =>
            l.city.toLowerCase().contains(q) ||
            l.country.toLowerCase().contains(q))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Location',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              autofocus: true,
              onChanged: (String v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search location',
                prefixIcon: const Icon(Icons.search, color: kTextGrey),
                filled: true,
                fillColor: const Color(0xFFF5F6F8),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      'No locations found',
                      style: TextStyle(color: kTextGrey),
                    ),
                  )
                : ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: kBorderGrey,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final LocationItem item = results[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on_outlined,
                            color: kPrimaryBlue),
                        title: Text(
                          item.city,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          item.country,
                          style:
                              const TextStyle(fontSize: 12.5, color: kTextGrey),
                        ),
                        onTap: () => Navigator.pop(context, item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
