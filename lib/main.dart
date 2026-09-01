import 'package:flutter/material.dart';

import 'screens/villas_home_screen.dart';

/// Shared accent colour for the prototype.
const Color kPrimaryBlue = Color(0xFF1A73E8);
const Color kBorderGrey = Color(0xFFE6E8EB);
const Color kTextGrey = Color(0xFF7A8087);

/// The app is mobile-first: content never grows wider than a phone.
const double kMobileMaxWidth = 430;
const Color kBackdropGrey = Color(0xFFECEFF3);

void main() => runApp(const VillasApp());

class VillasApp extends StatelessWidget {
  const VillasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Villas & Homestays',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryBlue),
        fontFamily: 'Roboto',
      ),
      builder: (BuildContext context, Widget? child) =>
          MobileShell(child: child),
      home: const VillasHomeScreen(),
    );
  }
}

/// Keeps the whole app at phone width and centres it on wider screens
/// (Chrome, Windows, tablets). On a real phone this is a no-op.
class MobileShell extends StatelessWidget {
  final Widget? child;

  const MobileShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (child == null) return const SizedBox.shrink();

    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isWide = screenWidth > kMobileMaxWidth;

    if (!isWide) return child!;

    return ColoredBox(
      color: kBackdropGrey,
      child: Center(
        child: Container(
          width: kMobileMaxWidth,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              vertical: BorderSide(color: kBorderGrey),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 24,
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: child,
        ),
      ),
    );
  }
}
