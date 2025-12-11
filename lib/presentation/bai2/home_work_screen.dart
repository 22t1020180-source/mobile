import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

const Color kPrimaryBlue = Color(0xFF003B95);

class HomeWorkScreen extends StatelessWidget {
  const HomeWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.heart, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.setting_2, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search Header
          _buildSearchHeader(),
          // Filter Buttons
          _buildFilterButtons(),
          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '757 chỗ nghỉ',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
          ),
          // Hotel List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel1/400/300',
                  name: 'aNhill Boutique',
                  rating: 5,
                  score: 9.5,
                  scoreLabel: 'Xuất sắc',
                  reviews: 95,
                  location: 'Huế',
                  distance: '0,6km',
                  roomType: '1 suite riêng tư: 1 giường',
                  price: 109,
                  hasBreakfast: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel2/400/300',
                  name: 'An Nam Hue Boutique',
                  rating: 4,
                  score: 9.2,
                  scoreLabel: 'Tuyệt hảo',
                  reviews: 34,
                  location: 'Cư Chính',
                  distance: '0,9km',
                  roomType: '1 phòng khách sạn: 1 giường',
                  price: 20,
                  hasBreakfast: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel3/400/300',
                  name: 'Huế Jade Hill Villa',
                  rating: 0,
                  score: 8.0,
                  scoreLabel: 'Rất tốt',
                  reviews: 1,
                  location: 'Cư Chính',
                  distance: '1,3km',
                  roomType: '1 biệt thự nguyên căn – 1.000 m²',
                  roomDetails:
                      '4 giường • 3 phòng ngủ • 1 phòng khách • 3 phòng tắm',
                  price: 285,
                  hasBreakfast: false,
                  isLastRoom: true,
                  noPaymentNeeded: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel4/400/300',
                  name: 'Êm Villa',
                  rating: 0,
                  score: 0,
                  scoreLabel: '',
                  reviews: 0,
                  location: 'Huế',
                  distance: '1,5km',
                  roomType: '1 biệt thự: 2 giường',
                  price: 150,
                  hasBreakfast: true,
                  isHostManaged: true,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      color: kPrimaryBlue,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange, width: 2),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.location, color: Colors.black54, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Xung quanh vị trí hiện tại',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Text(
              '23 thg 10 – 24 thg 10',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton(
            Iconsax.arrow_swap_horizontal,
            'Sắp xếp',
            hasIndicator: true,
          ),
          _buildFilterButton(Iconsax.filter, 'Lọc'),
          _buildFilterButton(Iconsax.map, 'Bản đồ'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    IconData icon,
    String label, {
    bool hasIndicator = false,
  }) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.black87, size: 20),
      label: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasIndicator)
            Container(
              margin: const EdgeInsets.only(left: 6),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: kPrimaryBlue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHotelCard({
    required String imageUrl,
    required String name,
    required int rating,
    required double score,
    required String scoreLabel,
    required int reviews,
    required String location,
    required String distance,
    required String roomType,
    String? roomDetails,
    required int price,
    bool hasBreakfast = false,
    bool isLastRoom = false,
    bool noPaymentNeeded = false,
    bool isHostManaged = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 140,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              if (hasBreakfast)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D6E3F),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Bao bữa sáng',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name & Stars
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryBlue,
                                  ),
                                ),
                              ),
                              if (rating > 0)
                                Row(
                                  children: List.generate(
                                    rating,
                                    (index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (isHostManaged)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                'Được quản lý bởi một host cá nhân',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          const SizedBox(height: 6),
                          // Score
                          if (score > 0)
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kPrimaryBlue,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    score.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  scoreLabel,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ' • $reviews đánh giá',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 4),
                          // Location
                          Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$location • Cách bạn $distance',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Iconsax.heart,
                        color: Colors.grey[400],
                        size: 24,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Room Type
                Text(
                  roomType,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (roomDetails != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      roomDetails,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                const SizedBox(height: 8),
                // Price
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'US\$$price',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Đã bao gồm thuế và phí',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      if (isLastRoom)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'Chỉ còn 1 căn với giá này trên Booking.com',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      if (noPaymentNeeded)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.tick_circle,
                                size: 14,
                                color: Colors.green[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Không cần thanh toán trước',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
