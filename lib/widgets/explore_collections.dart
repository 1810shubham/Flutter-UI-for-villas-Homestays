import 'package:flutter/material.dart';

import '../main.dart';

class _Collection {
  final String title;
  final String imageUrl;

  const _Collection(this.title, this.imageUrl);
}

const List<_Collection> _kCollections = <_Collection>[
  _Collection(
    'Party Villas',
    'https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6?w=600',
  ),
  _Collection(
    'Pool Villas',
    'https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=600',
  ),
  _Collection(
    'Heritage Stays',
    'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=600',
  ),
  _Collection(
    'Hill Retreats',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=600',
  ),
];

/// Bottom section of the home screen: a horizontal strip of collection cards.
class ExploreCollections extends StatelessWidget {
  const ExploreCollections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Explore Collections',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _kCollections.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (BuildContext context, int index) =>
                _CollectionCard(item: _kCollections[index]),
          ),
        ),
      ],
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final _Collection item;

  const _CollectionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 124,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const ColoredBox(
                color: Color(0xFFEFF3F8),
                child: Icon(Icons.photo_outlined, color: kTextGrey),
              ),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? progress) {
                if (progress == null) return child;
                return const ColoredBox(color: Color(0xFFEFF3F8));
              },
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0x00000000), Color(0xB3000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
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
