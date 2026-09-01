class Property {
  final String name;
  final String city;
  final String location;
  final double rating;
  final int price;
  final String imageUrl;
  final List<String> benefits;

  const Property({
    required this.name,
    required this.city,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.benefits,
  });
}

// Shared image pool, so every card has a photo without inventing dead links.
const String _img1 =
    'https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800';
const String _img2 =
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800';
const String _img3 =
    'https://images.unsplash.com/photo-1518780664697-55e3ad937233?w=800';
const String _img4 =
    'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800';
const String _img5 =
    'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800';
const String _img6 =
    'https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6?w=800';
const String _img7 =
    'https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=800';
const String _img8 =
    'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=800';
const String _img9 =
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800';
const String _img10 =
    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800';

/// Static dummy data. No API, no backend.
const List<Property> kDummyProperties = <Property>[
  // ---------------------------- Mumbai ----------------------------
  Property(
    name: 'Palm Villa',
    city: 'Mumbai',
    location: 'Juhu, Mumbai',
    rating: 4.5,
    price: 12500,
    imageUrl: _img1,
    benefits: ['Free Cancellation', 'Breakfast Included'],
  ),
  Property(
    name: 'Bandra Sky Homestay',
    city: 'Mumbai',
    location: 'Bandra West, Mumbai',
    rating: 4.3,
    price: 9800,
    imageUrl: _img6,
    benefits: ['Sea Facing', 'Wi-Fi Included'],
  ),
  Property(
    name: 'Madh Island Retreat',
    city: 'Mumbai',
    location: 'Madh Island, Mumbai',
    rating: 4.6,
    price: 16400,
    imageUrl: _img7,
    benefits: ['Private Pool', 'Caretaker Included'],
  ),

  // ---------------------------- Delhi -----------------------------
  Property(
    name: 'Lodhi Garden Homestay',
    city: 'Delhi',
    location: 'Lodhi Colony, New Delhi',
    rating: 4.4,
    price: 8900,
    imageUrl: _img8,
    benefits: ['Free Cancellation', 'Breakfast Included'],
  ),
  Property(
    name: 'Hauz Khas Studio Stay',
    city: 'Delhi',
    location: 'Hauz Khas, New Delhi',
    rating: 4.2,
    price: 7400,
    imageUrl: _img3,
    benefits: ['Wi-Fi Included', 'Free Parking'],
  ),
  Property(
    name: 'Chattarpur Farm Villa',
    city: 'Delhi',
    location: 'Chattarpur, New Delhi',
    rating: 4.7,
    price: 21500,
    imageUrl: _img4,
    benefits: ['Private Pool', 'Bonfire Evening'],
  ),

  // ----------------------------- Goa ------------------------------
  Property(
    name: 'Sea View Homestay',
    city: 'Goa',
    location: 'Candolim, North Goa',
    rating: 4.7,
    price: 15800,
    imageUrl: _img2,
    benefits: ['Free Cancellation', 'Private Pool'],
  ),
  Property(
    name: 'Anjuna Beach Villa',
    city: 'Goa',
    location: 'Anjuna, North Goa',
    rating: 4.5,
    price: 18200,
    imageUrl: _img7,
    benefits: ['Beach Access', 'Pet Friendly'],
  ),
  Property(
    name: 'Palolem Palm Cottage',
    city: 'Goa',
    location: 'Palolem, South Goa',
    rating: 4.4,
    price: 10600,
    imageUrl: _img6,
    benefits: ['Beach Access', 'Breakfast Included'],
  ),

  // -------------------------- Bangalore ---------------------------
  Property(
    name: 'Whitefield Garden Villa',
    city: 'Bangalore',
    location: 'Whitefield, Bangalore',
    rating: 4.3,
    price: 11400,
    imageUrl: _img10,
    benefits: ['Free Parking', 'Wi-Fi Included'],
  ),
  Property(
    name: 'Indiranagar Loft Stay',
    city: 'Bangalore',
    location: 'Indiranagar, Bangalore',
    rating: 4.6,
    price: 9200,
    imageUrl: _img8,
    benefits: ['Free Cancellation', 'Wi-Fi Included'],
  ),
  Property(
    name: 'Nandi Hills Farmstay',
    city: 'Bangalore',
    location: 'Nandi Hills, Bangalore',
    rating: 4.5,
    price: 14800,
    imageUrl: _img9,
    benefits: ['Mountain View', 'Bonfire Evening'],
  ),

  // ---------------------------- Manali ----------------------------
  Property(
    name: 'Mountain View Stay',
    city: 'Manali',
    location: 'Old Manali, Himachal Pradesh',
    rating: 4.6,
    price: 11200,
    imageUrl: _img3,
    benefits: ['Breakfast Included', 'Bonfire Evening'],
  ),
  Property(
    name: 'Solang Valley Cottage',
    city: 'Manali',
    location: 'Solang Valley, Himachal Pradesh',
    rating: 4.8,
    price: 13900,
    imageUrl: _img9,
    benefits: ['Mountain View', 'Caretaker Included'],
  ),
  Property(
    name: 'Riverside Wooden Villa',
    city: 'Manali',
    location: 'Vashisht, Himachal Pradesh',
    rating: 4.4,
    price: 10100,
    imageUrl: _img5,
    benefits: ['Free Cancellation', 'Pet Friendly'],
  ),

  // ---------------------------- Jaipur ----------------------------
  Property(
    name: 'Royal Heritage Villa',
    city: 'Jaipur',
    location: 'Amer Road, Jaipur',
    rating: 4.4,
    price: 13500,
    imageUrl: _img4,
    benefits: ['Free Cancellation', 'Heritage Property'],
  ),
  Property(
    name: 'Pink City Haveli',
    city: 'Jaipur',
    location: 'Bani Park, Jaipur',
    rating: 4.6,
    price: 11800,
    imageUrl: _img8,
    benefits: ['Heritage Property', 'Breakfast Included'],
  ),
  Property(
    name: 'Amber Fort View Stay',
    city: 'Jaipur',
    location: 'Amer, Jaipur',
    rating: 4.7,
    price: 16900,
    imageUrl: _img1,
    benefits: ['Private Pool', 'Caretaker Included'],
  ),

  // --------------------------- Udaipur ----------------------------
  Property(
    name: 'Lake View Homestay',
    city: 'Udaipur',
    location: 'Lake Pichola, Udaipur',
    rating: 4.8,
    price: 14200,
    imageUrl: _img5,
    benefits: ['Lake Facing', 'Breakfast Included'],
  ),
  Property(
    name: 'Aravalli Hilltop Villa',
    city: 'Udaipur',
    location: 'Badi Lake, Udaipur',
    rating: 4.6,
    price: 17600,
    imageUrl: _img7,
    benefits: ['Private Pool', 'Mountain View'],
  ),
  Property(
    name: 'Old City Haveli Stay',
    city: 'Udaipur',
    location: 'Gangaur Ghat, Udaipur',
    rating: 4.3,
    price: 9600,
    imageUrl: _img8,
    benefits: ['Heritage Property', 'Free Cancellation'],
  ),

  // ------------------------- Uttarakhand --------------------------
  Property(
    name: 'Rishikesh Riverside Cottage',
    city: 'Uttarakhand',
    location: 'Rishikesh, Uttarakhand',
    rating: 4.5,
    price: 8800,
    imageUrl: _img3,
    benefits: ['River Facing', 'Bonfire Evening'],
  ),
  Property(
    name: 'Nainital Lake Villa',
    city: 'Uttarakhand',
    location: 'Nainital, Uttarakhand',
    rating: 4.7,
    price: 12900,
    imageUrl: _img5,
    benefits: ['Lake Facing', 'Breakfast Included'],
  ),
  Property(
    name: 'Mussoorie Pine Homestay',
    city: 'Uttarakhand',
    location: 'Mussoorie, Uttarakhand',
    rating: 4.4,
    price: 10400,
    imageUrl: _img9,
    benefits: ['Mountain View', 'Free Parking'],
  ),

  // --------------------------- Lonavala ---------------------------
  Property(
    name: 'Misty Hills Villa',
    city: 'Lonavala',
    location: 'Tungarli, Lonavala',
    rating: 4.6,
    price: 15200,
    imageUrl: _img7,
    benefits: ['Private Pool', 'Caretaker Included'],
  ),
  Property(
    name: 'Bushi Lake Cottage',
    city: 'Lonavala',
    location: 'Bushi Dam, Lonavala',
    rating: 4.2,
    price: 8700,
    imageUrl: _img6,
    benefits: ['Lake Facing', 'Pet Friendly'],
  ),
  Property(
    name: 'Valley Edge Bungalow',
    city: 'Lonavala',
    location: "Lion's Point Road, Lonavala",
    rating: 4.5,
    price: 19400,
    imageUrl: _img4,
    benefits: ['Mountain View', 'Bonfire Evening'],
  ),

  // ---------------------------- Coorg -----------------------------
  Property(
    name: 'Coffee Estate Homestay',
    city: 'Coorg',
    location: 'Madikeri, Coorg',
    rating: 4.8,
    price: 11900,
    imageUrl: _img10,
    benefits: ['Breakfast Included', 'Caretaker Included'],
  ),
  Property(
    name: 'Misty Woods Villa',
    city: 'Coorg',
    location: 'Virajpet, Coorg',
    rating: 4.6,
    price: 14500,
    imageUrl: _img9,
    benefits: ['Mountain View', 'Free Cancellation'],
  ),
  Property(
    name: 'Kaveri Riverside Stay',
    city: 'Coorg',
    location: 'Kushalnagar, Coorg',
    rating: 4.4,
    price: 9900,
    imageUrl: _img3,
    benefits: ['River Facing', 'Pet Friendly'],
  ),

  // ----------------------------- Ooty -----------------------------
  Property(
    name: 'Nilgiri Tea Estate Villa',
    city: 'Ooty',
    location: 'Coonoor Road, Ooty',
    rating: 4.7,
    price: 13200,
    imageUrl: _img10,
    benefits: ['Mountain View', 'Breakfast Included'],
  ),
  Property(
    name: 'Colonial Hill Bungalow',
    city: 'Ooty',
    location: 'Fernhill, Ooty',
    rating: 4.5,
    price: 16800,
    imageUrl: _img8,
    benefits: ['Heritage Property', 'Bonfire Evening'],
  ),
  Property(
    name: 'Botanical Garden Homestay',
    city: 'Ooty',
    location: 'Ooty Town, Tamil Nadu',
    rating: 4.3,
    price: 8600,
    imageUrl: _img6,
    benefits: ['Free Cancellation', 'Free Parking'],
  ),

  // --------------------------- Alibaug ----------------------------
  Property(
    name: 'Nagaon Beachfront Villa',
    city: 'Alibaug',
    location: 'Nagaon Beach, Alibaug',
    rating: 4.7,
    price: 22400,
    imageUrl: _img2,
    benefits: ['Beach Access', 'Private Pool'],
  ),
  Property(
    name: 'Kihim Coconut Villa',
    city: 'Alibaug',
    location: 'Kihim, Alibaug',
    rating: 4.5,
    price: 17300,
    imageUrl: _img1,
    benefits: ['Private Pool', 'Caretaker Included'],
  ),
  Property(
    name: 'Alibaug Farm Retreat',
    city: 'Alibaug',
    location: 'Chondi, Alibaug',
    rating: 4.2,
    price: 12100,
    imageUrl: _img5,
    benefits: ['Pet Friendly', 'Bonfire Evening'],
  ),
];

/// Only the stays in the searched city.
List<Property> propertiesInCity(String? city) {
  if (city == null || city.isEmpty) return const <Property>[];
  final String q = city.trim().toLowerCase();
  return kDummyProperties
      .where((Property p) => p.city.toLowerCase() == q)
      .toList();
}
