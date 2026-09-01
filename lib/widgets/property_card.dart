import 'package:flutter/material.dart';

import '../main.dart';
import '../models/property.dart';

/// Reusable property listing card.
class PropertyCard extends StatelessWidget {
  final Property property;
  final int nights;

  const PropertyCard({super.key, required this.property, required this.nights});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorderGrey),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImage(),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  property.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  property.location,
                  style: const TextStyle(fontSize: 13, color: kTextGrey),
                ),
                const SizedBox(height: 10),
                ...property.benefits.map(
                  (String b) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.check,
                            size: 15, color: Color(0xFF1E9E63)),
                        const SizedBox(width: 6),
                        Text(
                          b,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF1E9E63),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '₹${_formatPrice(property.price)}',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        'for ${nights == 1 ? '1 Night' : '$nights Nights'}',
                        style: const TextStyle(fontSize: 12.5, color: kTextGrey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 170,
            width: double.infinity,
            child: Image.network(
              property.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const _ImageFallback(),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? progress) {
                if (progress == null) return child;
                return const _ImageFallback();
              },
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.star, size: 14, color: Color(0xFFFFB300)),
                  const SizedBox(width: 3),
                  Text(
                    property.rating.toString(),
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 12500 -> 12,500  (Indian grouping)
  static String _formatPrice(int price) {
    final String s = price.toString();
    if (s.length <= 3) return s;
    final String last3 = s.substring(s.length - 3);
    String rest = s.substring(0, s.length - 3);
    final List<String> groups = <String>[];
    while (rest.length > 2) {
      groups.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) groups.insert(0, rest);
    return '${groups.join(',')},$last3';
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      color: const Color(0xFFEFF3F8),
      child: const Icon(Icons.villa_outlined, size: 44, color: kTextGrey),
    );
  }
}
