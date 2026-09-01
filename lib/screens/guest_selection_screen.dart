import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/guest_counter.dart';

/// Value returned by the guest bottom sheet.
class GuestSelection {
  final int adults;
  final int children;

  const GuestSelection(this.adults, this.children);
}

/// Shows the guest bottom sheet and returns the chosen counts (or null).
Future<GuestSelection?> showGuestSelectionSheet(
  BuildContext context, {
  required int adults,
  required int children,
}) {
  return showModalBottomSheet<GuestSelection>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => GuestSelectionSheet(adults: adults, children: children),
  );
}

class GuestSelectionSheet extends StatefulWidget {
  final int adults;
  final int children;

  const GuestSelectionSheet({
    super.key,
    required this.adults,
    required this.children,
  });

  @override
  State<GuestSelectionSheet> createState() => _GuestSelectionSheetState();
}

class _GuestSelectionSheetState extends State<GuestSelectionSheet> {
  late int _adults = widget.adults;
  late int _children = widget.children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: kBorderGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Guests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            GuestCounter(
              label: 'Adults',
              subtitle: 'Age 13+',
              value: _adults,
              minValue: 1,
              onChanged: (int v) => setState(() => _adults = v),
            ),
            const Divider(height: 28, color: kBorderGrey),
            GuestCounter(
              label: 'Children',
              subtitle: 'Age 0 - 12',
              value: _children,
              minValue: 0,
              onChanged: (int v) => setState(() => _children = v),
            ),
            const SizedBox(height: 26),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(
                  context,
                  GuestSelection(_adults, _children),
                ),
                child: const Text(
                  'DONE',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
