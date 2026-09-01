import 'package:flutter/material.dart';

import '../main.dart';
import '../models/search_request.dart';

const Color _kTileGrey = Color(0xFFF4F6F8);

/// The Location / Date / Guests / SEARCH card on the home screen.
class SearchCard extends StatelessWidget {
  final SearchRequest request;
  final VoidCallback onLocationTap;
  final VoidCallback onDateTap;
  final VoidCallback onGuestTap;
  final VoidCallback onSearch;

  const SearchCard({
    super.key,
    required this.request,
    required this.onLocationTap,
    required this.onDateTap,
    required this.onGuestTap,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorderGrey),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          _Tile(onTap: onLocationTap, child: _buildLocation()),
          const SizedBox(height: 10),
          _Tile(onTap: onDateTap, child: _buildDates()),
          const SizedBox(height: 10),
          _Tile(onTap: onGuestTap, child: _buildGuests()),
          const SizedBox(height: 14),
          _GradientButton(label: 'SEARCH', onTap: onSearch),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          request.hasLocation ? request.city! : 'Search location',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: request.hasLocation ? Colors.black87 : kTextGrey,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          request.hasLocation
              ? (request.country ?? '')
              : 'Where do you want to stay?',
          style: const TextStyle(fontSize: 12, color: kTextGrey),
        ),
      ],
    );
  }

  Widget _buildDates() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _dateBlock(
            label: 'Check-in',
            value: request.checkIn == null
                ? 'Select date'
                : SearchRequest.heroDate(request.checkIn!),
            isSet: request.checkIn != null,
            align: CrossAxisAlignment.start,
          ),
        ),
        _nightsPill(),
        Expanded(
          child: _dateBlock(
            label: 'Check-out',
            value: request.checkOut == null
                ? 'Select date'
                : SearchRequest.heroDate(request.checkOut!),
            isSet: request.checkOut != null,
            align: CrossAxisAlignment.end,
          ),
        ),
      ],
    );
  }

  Widget _dateBlock({
    required String label,
    required String value,
    required bool isSet,
    required CrossAxisAlignment align,
  }) {
    final TextAlign textAlign =
        align == CrossAxisAlignment.end ? TextAlign.right : TextAlign.left;
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Text(
          value,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isSet ? Colors.black87 : kTextGrey,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: textAlign,
          style: const TextStyle(fontSize: 11.5, color: kTextGrey),
        ),
      ],
    );
  }

  Widget _nightsPill() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorderGrey),
      ),
      child: Text(
        request.hasDates ? request.nightsLabel : 'NIGHTS',
        style: const TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: kTextGrey,
        ),
      ),
    );
  }

  Widget _buildGuests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          request.guestLabel,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Guests',
          style: TextStyle(fontSize: 11.5, color: kTextGrey),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _Tile({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _kTileGrey,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: child,
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _GradientButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Color(0xFF2F8CFF), Color(0xFF0B57D0)],
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
