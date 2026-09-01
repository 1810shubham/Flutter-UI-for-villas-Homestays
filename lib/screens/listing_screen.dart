import 'package:flutter/material.dart';

import '../main.dart';
import '../models/property.dart';
import '../models/search_request.dart';
import '../widgets/property_card.dart';

class ListingScreen extends StatelessWidget {
  final SearchRequest request;

  const ListingScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final List<Property> results = propertiesInCity(request.city);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              request.city ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${request.dateLabel.replaceAll('→', '-')}  •  '
              '${request.totalGuests} Guests',
              style: const TextStyle(fontSize: 12, color: kTextGrey),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: kBorderGrey),
        ),
      ),
      body: results.isEmpty
          ? _EmptyState(city: request.city ?? '')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  child: Text(
                    results.length == 1
                        ? '1 stay in ${request.city}'
                        : '${results.length} stays in ${request.city}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kTextGrey,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, int index) =>
                        PropertyCard(
                      property: results[index],
                      nights: request.nights,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String city;

  const _EmptyState({required this.city});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.villa_outlined, size: 56, color: kBorderGrey),
            const SizedBox(height: 16),
            Text(
              'No stays in $city yet',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try Mumbai, Goa, Manali, Jaipur or Udaipur.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: kTextGrey),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: kPrimaryBlue,
                side: const BorderSide(color: kPrimaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Change location'),
            ),
          ],
        ),
      ),
    );
  }
}
