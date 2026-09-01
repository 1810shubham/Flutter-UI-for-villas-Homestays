import 'package:flutter/material.dart';

import '../main.dart';

/// Reusable "label  -  value  +" row.
class GuestCounter extends StatelessWidget {
  final String label;
  final String subtitle;
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const GuestCounter({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.subtitle = '',
    this.minValue = 0,
    this.maxValue = 20,
  });

  @override
  Widget build(BuildContext context) {
    final bool canDecrease = value > minValue;
    final bool canIncrease = value < maxValue;

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              if (subtitle.isNotEmpty) ...<Widget>[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: kTextGrey),
                ),
              ],
            ],
          ),
        ),
        _RoundButton(
          icon: Icons.remove,
          enabled: canDecrease,
          onTap: () => onChanged(value - 1),
        ),
        SizedBox(
          width: 44,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        _RoundButton(
          icon: Icons.add,
          enabled: canIncrease,
          onTap: () => onChanged(value + 1),
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _RoundButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = enabled ? kPrimaryBlue : kBorderGrey;
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
