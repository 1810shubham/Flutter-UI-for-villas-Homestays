import 'package:flutter/material.dart';

import '../main.dart';
import '../models/search_request.dart';
import '../widgets/explore_collections.dart';
import '../widgets/search_card.dart';
import 'date_selection_screen.dart';
import 'guest_selection_screen.dart';
import 'listing_screen.dart';
import 'location_screen.dart';

const String _kHeroImage =
    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=1000';

class VillasHomeScreen extends StatefulWidget {
  const VillasHomeScreen({super.key});

  @override
  State<VillasHomeScreen> createState() => _VillasHomeScreenState();
}

class _VillasHomeScreenState extends State<VillasHomeScreen> {
  final SearchRequest _request = SearchRequest();

  Future<void> _pickLocation() async {
    final LocationItem? result = await Navigator.push<LocationItem>(
      context,
      MaterialPageRoute<LocationItem>(
        builder: (_) => const LocationScreen(),
      ),
    );
    if (result == null || !mounted) return;
    setState(() {
      _request.city = result.city;
      _request.country = result.country;
    });
  }

  Future<void> _pickDates() async {
    final DateTimeRange? range = await Navigator.push<DateTimeRange>(
      context,
      MaterialPageRoute<DateTimeRange>(
        builder: (_) => DateSelectionScreen(
          checkIn: _request.checkIn,
          checkOut: _request.checkOut,
        ),
      ),
    );
    if (range == null || !mounted) return;
    setState(() {
      _request.checkIn = range.start;
      _request.checkOut = range.end;
    });
  }

  Future<void> _pickGuests() async {
    final GuestSelection? result = await showGuestSelectionSheet(
      context,
      adults: _request.adults,
      children: _request.children,
    );
    if (result == null || !mounted) return;
    setState(() {
      _request.adults = result.adults;
      _request.children = result.children;
    });
  }

  void _onSearch() {
    final String? error = _request.validate();
    if (error != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(error),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF323232),
          ),
        );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ListingScreen(request: _request),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHero(),
            // Pulls the white sheet up so it overlaps the hero image.
            Transform.translate(
              offset: const Offset(0, -22),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SearchCard(
                        request: _request,
                        onLocationTap: _pickLocation,
                        onDateTap: _pickDates,
                        onGuestTap: _pickGuests,
                        onSearch: _onSearch,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const ExploreCollections(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            _kHeroImage,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const _HeroFallback(),
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? progress) {
              if (progress == null) return child;
              return const _HeroFallback();
            },
          ),
          // Scrim: darkens the top for the app bar and the bottom for the text.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0x73000000),
                  Color(0x1A000000),
                  Color(0xA6000000),
                ],
                stops: <double>[0, 0.42, 1],
              ),
            ),
          ),
          // Pinned to the top. Without Positioned, StackFit.expand stretches
          // this Row to the full hero height and it centres vertically.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                child: Row(
                  children: <Widget>[
                    _CircleIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.maybePop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Villas & Homestays',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                          shadows: <Shadow>[
                            Shadow(color: Color(0xB3000000), blurRadius: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 38),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 20,
            right: 20,
            bottom: 66,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Group Escapades',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Private Pool • Caretaker & Food • Spacious Living',
                  style: TextStyle(color: Colors.white70, fontSize: 12.5),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 44,
            child: _PageDots(count: 4, activeIndex: 1),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x59000000),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, size: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  final int count;
  final int activeIndex;

  const _PageDots({required this.count, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(count, (int i) {
        final bool isActive = i == activeIndex;
        return Container(
          width: isActive ? 18 : 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white54,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _HeroFallback extends StatelessWidget {
  const _HeroFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kPrimaryBlue, Color(0xFF6BA8F5)],
        ),
      ),
      child: Icon(Icons.villa_outlined, size: 120, color: Color(0x2EFFFFFF)),
    );
  }
}
